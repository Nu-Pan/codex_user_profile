---
name: codex-self-improvement-skill-writing
description: Use when Codex self-improvement work needs to simplify prose inside bundle skills, component skills, or their references without changing responsibilities. Use for wording simplification, terminology normalization, duplicate removal, and section-level compression in skill documents. Do not use for workflow decomposition, config placement, or final reporting by itself.
---

# Codex Self Improvement Skill Writing

## Use when

- `SKILL.md` や skill `references/` の文面が長く、同じ説明が複数箇所へ重複しているとき
- skill の責務は維持したまま、短く直接的で誤読しにくい文章へ整えたいとき
- 同じ概念に複数の呼び方があり、bundle skill / component skill / reference のあいだで正本語彙へ揃えたいとき
- bundle skill / component skill / reference のどこへ何を残すかは概ね決まっており、主に書き方を改善したいとき

## Purpose

- この skill は Codex 自己改善タスクにおいて、skill を構成する文章を簡素化し、正本語彙を揃え、責務境界を保ったまま読みやすくする判断基準を定義する。
- workflow 全体の導線は bundle skill `codex-self-improvement` を正本とする。

## Inputs

- 変更対象の `SKILL.md` または skill `references/`
- その文書が担う責務、残すべき意味、削ってはいけない制約
- 必要なら関連 bundle skill / component skill / `AGENTS.md`

## Outputs

- 簡素化後の文面、またはその書き換え方針
- 採用した正本語彙と、置換または残置した別名の整理
- 削除した重複、参照へ逃がした詳細、維持した責務の整理
- 誤読を防ぐために残した境界条件や明示事項

## Quick start

- bundle skill `codex-self-improvement` を確認する。
- まず [`references/skill-writing-guide.md`](references/skill-writing-guide.md) と変更対象文書を読み、責務を変えずに削れる重複、長文、語彙の揺れを印付ける。

## Reference map

- [`references/skill-writing-guide.md`](references/skill-writing-guide.md)
  - skill を構成する文章を簡素化し、語彙を正本へ揃えるときの rewrite rules、section ごとの残し方、過剰な省略を避ける観点を確認するときに読む。
