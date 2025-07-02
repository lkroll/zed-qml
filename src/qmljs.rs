use zed::LanguageServerId;
use zed_extension_api::{self as zed, settings::LspSettings, Result};

struct QmlBinary {
    path: String,
    args: Option<Vec<String>>,
}

struct QmlJsExtension {
    cached_binary_path: Option<String>,
}

impl QmlJsExtension {
    fn language_server_binary_path(
        &mut self,
        _language_server_id: &LanguageServerId,
        worktree: &zed::Worktree,
    ) -> Result<QmlBinary> {
        //Fetch lsp arguments from settings file.
        let binary_args = LspSettings::for_worktree("qml", worktree)
            .ok()
            .and_then(|lsp_settings| lsp_settings.binary)
            .as_ref()
            .and_then(|binary_settings| binary_settings.arguments.clone());

        if let Some(path) = &self.cached_binary_path {
            return Ok(QmlBinary {
                path: path.clone(),
                args: binary_args,
            });
        }

        // Check for qmlls and qmlls6 binary names
        let binary_names = ["qmlls", "qmlls6"];

        for binary_name in binary_names.iter() {
            if let Some(path) = worktree.which(&binary_name) {
                self.cached_binary_path = Some(path.clone());
                return Ok(QmlBinary {
                    path: path.clone(),
                    args: binary_args,
                });
            }
        }

        Err(
            "qmlls binary not found in $PATH. Make sure you have a working Qt installation on your system.\nCheck the install instructions on Github for further information: https://github.com/lkroll/zed-qml?tab=readme-ov-file#qmlls-lsp"
                .to_owned(),
        )
    }
}

impl zed::Extension for QmlJsExtension {
    fn new() -> Self {
        Self {
            cached_binary_path: None,
        }
    }

    fn language_server_command(
        &mut self,
        language_server_id: &LanguageServerId,
        worktree: &zed::Worktree,
    ) -> Result<zed::Command> {
        let qml_binary = self.language_server_binary_path(language_server_id, worktree)?;
        Ok(zed::Command {
            command: qml_binary.path,
            args: qml_binary.args.unwrap_or_else(|| vec![]),
            env: Default::default(),
        })
    }
}

zed::register_extension!(QmlJsExtension);
