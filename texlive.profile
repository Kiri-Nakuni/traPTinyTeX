# texlive.profile for Alpine Linux (musl libc) - Infraonly Scheme
selected_scheme scheme-infraonly

# --- Platform (Alpine用にmuslのみ有効化) ---
binary_x86_64-linux 0
binary_x86_64-linuxmusl 1

# --- Directories (以前の設定を維持: /opt/texlive/2025) ---
TEXDIR /opt/texlive/2025
TEXMFLOCAL /opt/texlive/texmf-local
TEXMFSYSCONFIG /opt/texlive/2025/texmf-config
TEXMFSYSVAR /opt/texlive/2025/texmf-var
TEXMFHOME ~/texmf
TEXMFCONFIG ~/.texlive2025/texmf-config
TEXMFVAR ~/.texlive2025/texmf-var

# --- Options (ドキュメント・ソース・format作成なしで最小化) ---
option_doc 0
option_src 0
option_fmt 0

option_adjustrepo 1
option_autobackup 1
option_backupdir tlpkg/backups
option_desktop_integration 0
option_file_assocs 0
option_letter 0
option_path 0
option_post_code 1
option_w32_multi_user 1
option_write18_restricted 1
portable 0

# --- System Integration ---
option_sys_bin /usr/local/bin
option_sys_info /usr/local/share/info
option_sys_man /usr/local/share/man