# AI Engineering & Security Standards

_Purpose: Single source of truth for engineering, security, and documentation standards for all AI agents._

## 🛑 Non-Negotiable Technical Guardrails

- **Script Quality:** All shell/bash scripts MUST pass `shellcheck` validation with no errors before being committed or merged.

## 🛠️ Git Standards

- **Commits:**
    - **Conventional Commits:** Use the [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) specification for all commit messages.
    - **Body Formatting:** The commit message body MUST use a bulleted list (`- `) to describe the changes for better readability.
    - **Traceability:** ALL commits mediated by Gemini CLI MUST include a `Generated-by: Gemini CLI` trailer at the end of the commit message body.
    - **Example:**

        ```text
        feat: initialize Gemini CLI configuration

        Added core configuration files for Gemini CLI integration.

        Generated-by: Gemini CLI
        ```

    - **Optional:** Provide more details on changes in the commit message body.


## 📖 Documentation Standards

- **Tone:** Professional, strict, and technical.
- **Lifecycle:** Update documentation in the same PR as code changes.
- **Formatting & Linting:** Markdown (`prettier`), Shell Scripts (`shellcheck`).
