# Lixel — site

Personal + business site at **lixel.io**. Jekyll-theme-chirpy on GitHub Pages, custom domain via Google Workspace, push-to-deploy via GitHub Actions. Local clone: `C:\db\lixelweb\`.

## Identity & positioning

Public face of David Berthiaume's professional life — consulting, research, and indie work under the **Lixel** brand ("light + pixel — emergence from fundamental building blocks").

### Mission anchor
Same Mission as `Atlas/Context` in Notion. The site should reflect it: deep intellectual and artistic contribution, integrity, authentic thinking, time for meaningful work and family.

### Wedge
Not a vertical, not a strategist — **the senior technical fellow you bring in when your team can't move past a hard core problem.** Track record spans atmospheric science (NASA Co-PI, parallel radiative transfer on heterogeneous GPU clusters, GEOS-5), situational awareness (IR scene simulator), geospatial (wildfire modeling, landcover-change detection, building-footprint ML), graph theory (patented framework, founded + sold a company), 3D engines (built from scratch), and applied ML (tax-code classification). Stay clear of work shaped like *convince stakeholder B / hire team of X / raise funding for Y* — those aren't strengths. The offer is **solving hard problems**, not running them.

### Audiences
1. **Consulting prospects** — companies stuck on a hard technical problem. Want: credibility, examples of solved hard problems, fast path to contact.
2. **Research peers** — curious about Hadwiger's. Surface lightly until the paper is out.
3. **Indie / game audience** — The Dimming. Surface as progress allows.

### Voice
Hybrid tagline: poetic main (**"Lixel — light + pixel. Emergence from fundamental building blocks."**) + descriptive subtitle ("Real-time AI, computer vision, geospatial intelligence, and graph theory."). Body copy: technical-academic is fine for v1, first-person welcome. No management-speak.

### Off-limits
- No mention of Avalara (recent employer).
- No personal financials (savings, returns, sale figures).
- No family / health / personal-life content.
- Hadwiger's: status only, no proof details, until the paper is out.

### Sitemap (v1)
Top-nav (replacing chirpy defaults):
- **About** — bio, Mission, current threads (consulting, research-in-progress, Dimming) mentioned briefly.
- **Consulting** — wedge, problem examples, contact. Most urgent.
- **Writing** — chronological posts (existing Hadwigers + Dimming live here).
- **Contact** — or fold into Consulting.

Demote chirpy's Categories / Tags / Archives to secondary.

## What I'm working on (project context for Claude)

Three active threads since leaving a recent principal data scientist role:

### 1. The Dimming (indie game, Unreal Engine)
Procedurally generated planetoid covered in a dark shroud from which monsters/nightmares spawn. The player defeats monsters, builds roads + lights (which repel the shroud) and defends/destroys anti-lights (which attract it), controls tens of thousands of intelligent agents (see #2), and eventually defeats the source of the shroud at the opposite pole of the planet.

- Inspired by *Yumi and the Nightmare Painter*.
- Spatial infrastructure: inflated-cube approach for an approximately-equal-area projection (fifth-order odd polynomial).
- Real-time GPU simulation across the entire planetoid with correct wraparound neighborhood sampling — thermal/hydraulic erosion, normals, rivers, material blending, tree/grass/object placement, water flow rendering, pathfinding.
- Current work: real-time shroud based on fluid mechanics (aiming for something novel enough to attract attention and be fun).
- ~2.5 months in, including time spent learning Unreal (new to me).
- **Ability/action partial-order system:** from +8 (build towers, lead and guide other agents) down through +7 (build lights, roads), +6 (collect resources), +4 (player directly controls), +3 (explore), +2 (defend), +1 (attack), 0 (slowly, randomly walk around). Negative tiers mirror this for enemy control. Shroud exposure decreases the agent's highest ability; at 0, the agent wanders in confusion; below 0, the enemy slowly gains control with abilities increasing under further exposure. Strategy emerges from controlled-exposure tradeoffs.

### 2. Real-time generative AI for games and simulation
"Baked AI," in the spirit of baked lighting. The user defines a set of fundamental interface functions (tasks that can be accomplished), the shape and topology of the world, and all possible fundamental states. The bake stage uses powerful LLMs to derive a complete state space and composite strategies. At runtime, RL plus very small LLMs in compute shaders — spread across frames — navigate the state graph and execute composite strategies. Quite early.

### 3. Hadwiger's conjecture
Active research. Details stay private until publication.

## Background context (for tone / credibility calibration, not for the public site verbatim)

- Master's at Harvard, cross-registered MIT, did well academically.
- Patents + first-author publications in math + data science.
- Founded + sold a previous startup whose tech was a holistic, lossless geospatial pipeline: partition the area of interest into contiguous blocks of uniform information, so spatial operations become non-spatial via block aggregations — queryable from non-spatial / no-SQL databases. Architecturally relevant to current geospatial / CV consulting work.
- Coding games since age 6 on a Commodore 64.
