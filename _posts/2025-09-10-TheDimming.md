---
title: A planetary simulation system
date: 2025-09-10 
categories: [Simulations, GPU, Topology]
tags: [simulation, inflated, cube, geospatial]     # TAG names should always be lowercase
---

The Dimming (a rather Stephen King-esque title, I know!) is the working name for a solo indie game I've been developing for ~3 months. It explores themes of light, darkness, agency, and intelligence. This game will make use of a real-time generative AI framework I'm developing — more on that in future posts. It's been a lot of fun to work on!

{% include embed/youtube.html id='v-jWnpesxY4' %}

## Summary

In this game, the player controls tens of thousands of intelligent agents across an entire planet. A dark shroud begins to engulf the world. From this shroud, dark monsters and nightmares spawn.

Players can build lights, roads, buildings, and other structures to repel and reshape the shroud, while managing resources and defending against what emerges. The enemy, born from darkness, can construct **antilights** that attract and strengthen the shroud, creating pockets of growing corruption.

## Agency System

The entire game revolves around a system of **agency and intelligence**, a partial ordering of abilities that increase as agents are exposed to light, and degrade in darkness. The longer an agent remains in the light, the more powerful and intentional their actions become. In the shroud, their cognition fades. If they fall far enough, they may even come under enemy control.

| Agency  | Control State               | Example Actions                     | Thematic Meaning                       |
|--------|-----------------------------|-------------------------------------|----------------------------------------|
| +8     | High Clarity (Light)        | Build towers, guide other agents    | Leadership, emergent intelligence      |
| +7     |                             | Build lights, construct roads       | Infrastructure, long-term planning     |
| +6     |                             | Collect resources                   | Purposeful autonomy                    |
| +4     |                             | **Direct player control**           | Individual agency, heroism             |
| +3     |                             | Explore unknown regions             | Curiosity, discovery                   |
| +2     |                             | Defend structures or allies         | Loyalty, basic judgment                |
| +1     |                             | Attack nearby enemies               | Reflexive aggression                   |
|  0     | Edge of Control             | Wander aimlessly                    | Confusion, loss of purpose             |
| -1     | Enemy Influence Begins      | Attack player structures            | Manipulated intent                     |
| -2     |                             | Follow enemy paths                  | Subverted will                         |
| -4     |                             | Build negative lights               | Reinforce darkness, suppress clarity   |
| -6     |                             | Lead other enemy agents             | Corrupted leadership                   |
| -8     | Full Enemy Control (Dark)   | Build dark towers, lead offensives  | Strategic malice                       |

My hope is to achieve deep strategic gameplay through this system — emerging from a relatively small set of elegant mechanics, similar to games like **chess** or **Go**.

## Simulation System

Procedural generation is becoming ubiquitous in games, but **The Dimming** takes it further by simulating an entire planet in real time. Unlike typical handcrafted terrain or noise-based maps, the world is built using a **real-time physical simulation system** that continuously updates during play.

Using an **inflated cube topology** to form a spheroid, combined with a **fifth-order odd polynomial equal-area projection**, I generate a seamless, cell-based simulation surface. This allows for physically-based terrain generation, hydraulic and thermal erosion, water flow, river formation, and the real-time spread of the shroud via fluid mechanics and flow/influence fields.

To support performance, I built a **general frame distribution system** to efficiently update the six cube faces of the simulation surface across frames — enabling high-fidelity, planet-wide simulations at interactive framerates.

This unlocks gameplay possibilities I haven’t seen in any other game — and helps bring the world to vivid life.

---

Well, I wanted to keep this piece relatively brief and non-technical. (Hey, at least there aren't any equations in this post!) More technical deep-dives are coming soon!