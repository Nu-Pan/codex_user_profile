# Editor Guide

## Purpose

- prose / config / reference の文章を、責務を変えずに短く直接的にする基準を定義する。
- 文章整理の目的は情報量を増やすことではなく、入口、責務、引き渡し条件、正本語彙を誤読なく見せることである。

## Preserve before editing

- trigger 条件、out-of-scope、担当責務
- shared rule、profile-level `developer_instructions`、root skill の routing の正本がどこか
- 同じ概念に複数の呼び方がある場合は、その正本語彙がどこで定義されているか
- role contract の `Inputs`、`Outputs`、`Write policy`
- role が root handoff の不足を local facts で復元できるか
- `only if`、`do not`、`例外` のような境界を表す語
- 必要な参照先と、正本への導線

## Core rewrite rules

- 1 行 1 意図の短い箇条書きを優先する。
- 抽象名詞より、観測可能な行動や判断を表す動詞を使う。
- まず重複を削除し、その後に言い換える。削除で足りる箇所に新しい説明を足さない。
- root skill は入口と spawn policy だけを持ち、実作業は child agent に逃がす。
- child role の contract は、root handoff が薄いときの local bootstrap 条件まで含めて書く。
- role config の `developer_instructions` は role-local read-first docs を閉じる場所として扱い、root skill は再掲しない。
- legacy compatibility skill は handoff だけを書き、canonical な本文を抱え込まない。
- reference は深い判断基準、変換ルール、例外条件だけを持ち、入口説明を繰り返さない。
- OpenAI 公式 docs で足りる一般的な内容は、skill family に再掲せず、公式 docs への導線に置き換える。
- 文量を減らすために重要な境界語を落とさない。

## Section lens for root skills

- `Use when`: 具体的な trigger だけを書く。
- `Purpose`: その skill が何の入口かと、正本がどこかを 1-2 bullet で示す。
- `Recommended flow`: role sequence と利用条件だけを書く。child role は local docs で自己起動できる前提を含める。
- `Child agent roles`: 各 role の責務を 1 行で書き、必要な local bootstrap 条件は role config に閉じる前提で短く添える。
- `Quick start`: 最初に読む文書と最初の行動だけを書く。

## Section lens for compatibility shims

- `Use when`: 旧 skill 名が必要な場合だけを書く。
- `Purpose`: legacy 入口であることと、canonical role が何かだけを書く。
- `Quick start`: root skill、role contract、局所 reference の順で導く。
- 新しい責務定義や長い workflow 本文は書かない。

## Section lens for references

- 変換ルール、判断基準、例外、短いテンプレ断片に絞る。
- task 固有の事情ではなく、次の自己改善タスクでも再利用できる内容を残す。
- 複数の独立した話題が混ざるなら、短い見出しで分けるか別 reference に分離する。

## Rewrite process

1. その文書の責務と、削ってはいけない意味を先に固定する。
2. 重複している説明、正本でない説明、同じ概念の別名を印付ける。
3. 削除だけでよい重複を先に消す。
4. 1 行 1 意図になるように言い換える。
5. 長い説明は、正本 1 か所へ集約するか `references/` へ逃がす。
6. trigger、責務、handoff、参照先、正本語彙が残っているかを見直す。

## Do not oversimplify

- 推奨順序を hard gate に変えない。
- `正本`、`必要な場合だけ`、`例外`、`do not` のような境界語を落とさない。
- あいまいな「関連文書を参照する」だけに置き換えず、必要な文書名を残す。
- role contract から `Inputs`、`Outputs`、`Write policy` を落とさない。
- 用語を揃えるために、責務境界まで潰さない。
