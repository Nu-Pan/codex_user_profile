
# codex user profile

## これは？

- 自分用の `~/.codex`, `~/.agents` をバージョン管理するためのリポジトリ
- Codex CLI の「リポジトリによらない共通設定」を開発するためのリポジトリ

## 運用ワークフロー

- Linux 専用
- 「`~/.codex`, `~/.agents` 上の各種設定ファイル」を「このリポジトリ上のファイルを指すシンボリックリンク」で置き換える
- `./install.sh` でこの置き換え操作が行われる

## 開発ワークフロー

- Codex CLI を使って Codex CLI の設定を開発する
- ただし、このリポジトリ固有の Codex CLI 設定は一切持たない
- `dot_codex` (=`~/.codex`), `dot_agents` (=`~/.agents`) 上に設定を用意して、それを使う
- つまり Codex CLI から見れば、ユーザーからの指示に基づいた自己開発ということになる

## スキル `codex-self-improvement` の典型的な使い方

- `codex_meta` profile で起動する
    ```
    codex -p codex_meta
    ```
- プロンプト例
    ```
    $codex-self-improvement 一般的な質問に答える汎用的なワークフローを追加してください
    ```
- プロンプト例
    ```
    $codex-self-improvement を使って $codex-self-improvement 全体を改善してください
    ```

