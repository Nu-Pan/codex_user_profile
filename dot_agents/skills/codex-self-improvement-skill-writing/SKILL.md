---
name: codex-self-improvement-skill-writing
description: Legacy compatibility entrypoint for the old skill-writing component-skill name. Use when older prompts or docs mention this name. Use for handing off to root skill `codex-self-improvement` and child role `si_editor`. Do not use as the canonical source for new self-improvement work.
---

# Codex Self Improvement Skill Writing

## Use when

- 既存の prompt や文書がこの旧 skill 名を参照しているとき
- bounded な prose / config 編集が必要で、canonical な担当 role を知りたいとき

## Purpose

- この legacy skill は旧 component-skill 名から root skill `codex-self-improvement` と child role `si_editor` へ handoff する compatibility entrypoint である。
- canonical な文面整理 rule は関連 reference を正本とし、この skill 自体は新規 workflow の正本にはしない。

## Inputs

- 変更対象の `SKILL.md` または skill `references/`
- その文書が担う責務、残すべき意味、削ってはいけない制約
- 必要なら関連 root skill / compatibility skill / `AGENTS.md`

## Outputs

- `si_editor` が返す bounded edit の期待 shape
- root skill と関連 reference への handoff 導線

## Quick start

- 軽量 self-improvement session を使う場合は `codex_meta` profile で root skill 側から開始する。
- まず root skill [`codex-self-improvement`](../codex-self-improvement/SKILL.md) を確認する。
- 次に [`../codex-self-improvement/references/role-contracts.md`](../codex-self-improvement/references/role-contracts.md) を読み、canonical role が `si_editor` であることを確認する。
- 文面整理 rule 自体は [`references/editor-guide.md`](references/editor-guide.md) を読む。

## Reference map

- [`../codex-self-improvement/references/role-contracts.md`](../codex-self-improvement/references/role-contracts.md)
  - `si_editor` の入力と期待出力を確認するときに読む。
- [`references/editor-guide.md`](references/editor-guide.md)
  - prose / config を bounded scope で整理し、正本語彙を揃えるときの rewrite rules、section ごとの残し方、過剰な省略を避ける観点を確認するときに読む。
