# traPTinyTeX

Alpine Linux をベースにした軽量な日本語 LaTeX Docker 環境です。
TeX Live の最小限の構成（TinyTeX ライク）に必要なパッケージを追加し、日本語環境（uplatex, lualatex, xelatex）をすぐに利用できるように設定しています。

## 特徴

- **軽量**: Alpine Linux ベースのイメージを採用。
- **マルチエンジン対応**: `uplatex`, `lualatex`, `xelatex` に対応しています。
- **便利スクリプト**:
  - ビルド用スクリプト (`build`, `buildlua`, `buildxe`)
  - テンプレート作成スクリプト (`template`, `templatelua`, `templatexe`)
  - FAQ (`faq`)
- **フォント**: HackGen フォントがプリインストールされています。
- **開発環境**: VS Code Dev Containers (`.devcontainer`) に対応しており、手軽に環境構築が可能です。

## 使い方

### Dev Containers (推奨)

1. VS Code と Docker Desktop がインストールされていることを確認します。
2. このリポジトリをクローンし、VS Code で開きます。
3. "Reopen in Container" を選択すると、環境が自動的に構築されます。

### コマンド

コンテナ内で以下のコマンドが利用可能です。

#### プロジェクトの初期化（テンプレート作成）

```bash
# uplatex 用テンプレート作成
template <filename>

# lualatex 用テンプレート作成
templatelua <filename>

# xelatex 用テンプレート作成
templatexe <filename>
```

#### ビルド

`latexmk` をラップした以下のコマンドで PDF を生成できます。

```bash
# uplatex でビルド
build <filename.tex>

# lualatex でビルド
buildlua <filename.tex>

# xelatex でビルド
buildxe <filename.tex>
```

#### その他

```bash
# ヘルプ/FAQの表示
faq
```

## 構成

- `Dockerfile`: イメージのビルド定義
- `.devcontainer/`: VS Code Dev Container 設定
- `texlive.packages`: インストールされる TeX Live パッケージリスト
- `hackgen/`: 同梱されているフォントファイル
- `templates/`: 各種スクリプトとテンプレートファイル

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

**Note:** The fonts included in the `hackgen/` directory are licensed under the **SIL Open Font License 1.1**.
```
