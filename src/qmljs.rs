use std::fs;
use zed::LanguageServerId;
use zed_extension_api::{self as zed, Result};

struct QmlJsExtension {
    cached_binary_path: Option<String>,
}

impl QmlJsExtension {
    fn language_server_binary_path(
        &mut self,
        language_server_id: &LanguageServerId,
        _worktree: &zed::Worktree,
    ) -> Result<String> {
        if let Some(path) = &self.cached_binary_path {
            if fs::metadata(path).map_or(false, |stat| stat.is_file()) {
                zed::set_language_server_installation_status(
                    language_server_id,
                    &zed::LanguageServerInstallationStatus::None,
                );
                return Ok(path.to_owned());
            }
        }

        let mut binary_path = format!("/usr/bin/qmlls");

        if !fs::metadata(&binary_path).map_or(false, |stat| stat.is_file()) {
            binary_path = format!("/usr/bin/qmlls6");
        }

        if !fs::metadata(&binary_path).map_or(false, |stat| stat.is_file()) {
            zed::set_language_server_installation_status(
                language_server_id,
                &zed::LanguageServerInstallationStatus::Failed(
                    "qmlls is not installed locally".to_string(),
                ),
            );
        }

        self.cached_binary_path = Some(binary_path.clone());
        Ok(binary_path)
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
