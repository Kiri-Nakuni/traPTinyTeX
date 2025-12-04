# texlive.profile for Alpine Linux (musl libc)
selected_scheme scheme-custom

# --- Collections (日本語環境 + 数学・理系向け構成) ---
collection-basic 1
collection-bibtexextra 1
collection-binextra 1
collection-fontsrecommended 1
collection-langcjk 1
collection-langenglish 1
collection-langjapanese 1
collection-latex 1
collection-latexextra 1
collection-latexrecommended 1
collection-luatex 1
collection-mathscience 1
collection-pictures 1

# --- Platform (Alpine用にmuslのみ有効化) ---
# ここが修正の重要ポイントです
binary_x86_64-linux 0
binary_x86_64-linuxmusl 1

# --- Directories (環境に合わせて書き換えてください) ---
# Dockerなどで使う場合は /opt/texlive/2025 などが一般的です
TEXDIR /opt/texlive/2025
TEXMFLOCAL /opt/texlive/texmf-local

# --- Options ---
option_doc 0
option_src 0
option_fmt 0

option_adjustrepo 1
option_autobackup 1
option_backupdir tlpkg/backups
option_desktop_integration 0
option_file_assocs 0
option_letter 0
option_post_code 1
option_w32_multi_user 1
option_write18_restricted 1
portable 0
option_path 1
tlpdbopt_create_formats 1
tlpdbopt_install_docfiles 0
tlpdbopt_install_srcfiles 0