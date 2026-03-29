# Skill Writing Guide

## Purpose

- `SKILL.md` や skill `references/` の文章を、責務を変えずに短く直接的にする基準を定義する。
- 文章整理の目的は情報量を増やすことではなく、入口、責務、引き渡し条件、正本語彙を誤読なく見せることである。

## Preserve before editing

- trigger 条件、out-of-scope、担当フェーズ
- session 契約や workflow 全体導線の正本がどこか
- 同じ概念に複数の呼び方がある場合は、その正本語彙がどこで定義されているか
- component skill の `Inputs`、`Outputs`、`Reference map`
- `only if`、`do not`、`例外` のような境界を表す語
- 必要な参照先と、正本への導線

## Core rewrite rules

- 1 行 1 意図の短い箇条書きを優先する。
- 抽象名詞より、観測可能な行動や判断を表す動詞を使う。
- 同じ説明が `Use when`、`Purpose`、`Quick start` に重複する場合は、正本 1 か所だけに残し、他は導線へ短縮する。
- 同じ概念に複数の呼び方がある場合は、正本語彙を 1 つ決め、同じ bundle skill 配下の component skills と `references/` でもそれに揃える。
- bundle skill は入口と導線だけを持ち、詳細手順や変換ルールは component skill / `references/` に逃がす。
- component skill は局所責務だけを書き、workflow 全体の説明や他フェーズの段取りを再掲しない。
- reference は深い判断基準、変換ルール、例外条件だけを持ち、入口説明を繰り返さない。
- 例が責務や境界の理解に寄与しないなら削る。
- 文量を減らすために重要な境界語を落とさない。

## Canonical terms for this bundle

- `bundle skill`
- `component skill`
- `reference`
- `session 契約`
- `durable 設定`
- `canonical path`
- `local working path`

- この bundle では、上の語を正本語彙として扱い、不要な別名を増やさない。

## Terminology normalization

- まず、同じ概念を指している別名を洗い出す。
- 既に正本語彙があるなら、それを優先する。既定では bundle skill か、その概念を定義している reference を正本とする。
- 正本語彙がまだ無い場合は、その skill family 内で最も短く、責務境界が分かりやすく、既存出現が多い語を候補にする。
- 単数形と複数形は意味が違う場合だけ使い分ける。概念 1 つを指す箇所で不用意に複数形へ寄せない。
- 日本語名と英語名を併記するのは、読解上の必要がある場合だけに限る。単なる別名の併存は増やさない。
- 新しい語彙を導入したら、その語を bundle skill または対応 reference のどこかで自然に読めるようにする。

## Section lens for bundle skills

- `Use when`: 具体的な trigger だけを書く。
- `Purpose`: その skill が何の入口かと、正本がどこかを 1-2 bullet で示す。
- `Recommended flow`: フェーズ名と利用条件だけを書く。
- `Component skills`: 各 skill の責務を 1 行で書く。
- `Quick start`: 最初に読む文書と最初の行動だけを書く。

避ける。

- workflow 全文の再掲
- 各フェーズの詳細手順
- 同じ注意書きの重複

## Section lens for component skills

- `Use when`: その skill 単体の trigger だけを書く。
- `Purpose`: 局所責務と bundle skill への handoff だけを書く。
- `Inputs` / `Outputs`: その phase に必要な最小限だけを書く。
- `Quick start`: 最初に読む reference と最初の局所手順を書く。

避ける。

- session 契約の再掲
- 他フェーズの説明
- bundle skill と同じ導線説明の重複

## Section lens for references

- 変換ルール、判断基準、例外、短いテンプレ断片に絞る。
- task 固有の事情ではなく、次の自己改善タスクでも再利用できる内容を残す。
- 複数の独立した話題が混ざるなら、短い見出しで分けるか別 reference に分離する。

## Rewrite process

1. その文書の責務と、削ってはいけない意味を先に固定する。
2. 重複している説明、正本でない説明、同じ概念の別名を印付ける。
3. 1 行 1 意図になるように言い換える。
4. 長い説明は、正本 1 か所へ集約するか `references/` へ逃がす。
5. trigger、責務、handoff、参照先、正本語彙が残っているかを見直す。

## Do not oversimplify

- 推奨順序を hard gate に変えない。
- `正本`、`必要な場合だけ`、`例外`、`do not` のような境界語を落とさない。
- あいまいな「関連文書を参照する」だけに置き換えず、必要な文書名を残す。
- `Inputs` / `Outputs` や `Reference map` を削って、局所責務が追えなくならないようにする。
- 用語を揃えるために、単数と複数の意味差や責務境界まで潰さない。

## Rewrite patterns

- 長い説明を bundle skill に置き続けるくらいなら、概要だけ残して component skill / reference へ渡す。
- `この skill は <局所責務> の判断基準を定義する。workflow 全体の導線は <bundle skill> を正本とする。` の型を優先する。
- `まず <primary reference> を読む。必要なら関連 skill / \`references/\` を辿る。` のように、最初の一手を明示する。
- 語彙統一が主題なら、`<canonical term> を正本とし、<alias> はこの scope では使わない。` のように判断結果を短く残す。
