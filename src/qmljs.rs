use zed::LanguageServerId;
use zed_extension_api::{self as zed, Result};

struct QmlJsExtension {
    cached_binary_path: Option<String>,
}

impl QmlJsExtension {
    fn language_server_binary_path(
        &mut self,
        _language_server_id: &LanguageServerId,
        worktree: &zed::Worktree,
    ) -> Result<String> {
        if let Some(path) = &self.cached_binary_path {
            return Ok(path.clone());
        }

        let binary_name = "qmlls";

        if let Some(path) = worktree.which(&binary_name) {
            self.cached_binary_path = Some(path.clone());
            return Ok(path.clone());
        }

        Err(
            "qmlls binary not found in $PATH. Make sure you have a working QT installation on your system.\nCheck the install instructions on Github for further information."
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
        Ok(zed::Command {
            command: self.language_server_binary_path(language_server_id, worktree)?,
            args: vec![],
            env: Default::default(),
        })
    }
}

zed::register_extension!(QmlJsExtension);
