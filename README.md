<p align="center">
  <a href="https://discord.com/users/1260317666841858144" target="_blank">
    <img src="https://img.shields.io/badge/DISCORD-101010?style=for-the-badge&logo=discord&logoColor=5865F2" alt="Discord" />
  </a>
  <a href="https://instagram.com/aerethium" target="_blank">
    <img src="https://img.shields.io/badge/INSTAGRAM-101010?style=for-the-badge&logo=instagram&logoColor=E4405F" alt="Instagram" />
  </a>
</p>

<p align="center">
  <a href="https://git.io/typing-svg">
    <img src="https://readme-typing-svg.demolab.com?font=Fira+Code&weight=600&size=17&pause=1000&color=38BDF8&center=true&vCenter=true&width=600&lines=%24+echo+%22Just+a+tech+enthusiast+tinkering+around~%22;%24+echo+%22Aspiring+1337+Student%22" alt="Typing SVG" />
  </a>
</p>

<p align="center">
  <img src="./banner.gif" width="100%" alt="Banner GIF" />
</p>

```bash
#!/usr/bin/env bash
# ============================================================================
#  AERETHIUM // TINKERING AROUND ON ARCH
# ============================================================================

declare -A self=(
  [user]="aerethium"
  [status]="Aspiring 1337 Student"
  [bio]="Just a tech enthusiast tinkering around~"
  [os]="Arch Linux (btw)"
  [editor]="Neovim"
)

languages=("C" "Bash")
tools=("Linux" "Arch" "Git" "Neovim")

main() {
  printf '%s@github :: %s\n' "${self[user]}" "${self[status]}"
  printf 'bio      : %s\n'   "${self[bio]}"
  printf 'os       : %s\n'   "${self[os]}"
  printf 'editor   : %s\n'   "${self[editor]}"
  printf 'langs    : %s\n'   "${languages[*]}"
  printf 'tools    : %s\n'   "${tools[*]}"

  if ! command -v nvim >/dev/null 2>&1; then
    echo "try again." >&2
    return 1
  fi
}

main "$@"
```
