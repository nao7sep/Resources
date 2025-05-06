# README Generation Prompt

This file contains a reusable prompt to generate consistent and professional `README.md` files from technical specification documents.

## Purpose

Use this prompt with an AI assistant or automation tool to create a clear and accurate README for your project. It emphasizes readability, relevance, and technical clarity without including unnecessary code dumps or rigid templates.

The prompt assumes that the most recent specification file (e.g. `spec.md`, `*-specification.md`) exists in the project directory.

## Prompt

Generate a clear, professional `README.md` for this project based on the most recent specification file in the directory (e.g., `*-specification.md`, `spec.md`, etc.).

Guidelines:

- Adapt the structure of the README to fit the specific project — do **not** follow a fixed template.
- Include only sections that are appropriate for this application (e.g., Overview, Features, Configuration, How It Works), and omit any that are irrelevant.
- Avoid including code blocks, class definitions, or full configuration dumps — summarize technical content in clean prose or bullet points.
- Maintain a neutral, concise, and developer-focused tone.
- Do **not** use emojis, badges, marketing phrases, or fluff.
- Assume the reader is a developer familiar with .NET or similar ecosystems.

Focus on clarity, usefulness, and summarizing the purpose, structure, and behavior of the application as described in the specification.
