# vim-blink

<p align="center">
<img alt="screencast" src="https://raw.githubusercontent.com/leafOfTree/leafOfTree.github.io/master/vim_run_screencast.gif" />
</p>

Blink to anywhere in INSERT mode.

## Installation

<details>
<summary><a>How to install</a></summary>

- [VundleVim][1]

        Plugin 'leafOfTree/vim-blink'

- [vim-pathogen][2]

        cd ~/.vim/bundle && \
        git clone https://github.com/leafOfTree/vim-blink --depth 1

- [vim-plug][3]

        Plug 'leafOfTree/vim-blink'
        :PlugInstall

- Or manually, clone this plugin to `path/to/this_plugin`, and add it to `rtp` in vimrc

        set rtp+=path/to/this_plugin

<br />
</details>

Please stay up to date. Feel free to open an issue or a pull request.

## Usage

With config

```vim
let g:blink_point = {
      \'javascript':  '(|),{|},[|],{\n\s*|\n\s*},>|<,"|",''|''',
      \}
```

Open a javascript file and in INSERT mode, press <kbd>c-n</kbd> or <kbd>c-p</kbd>.

## Configuration

#### `g:blink_point`: `{ key: <filetype>, value: pattern }`

- description: 

    Filetype related `pattern` that defines blink points which are seprated by `,`. `|` marks cursor location.

- default: `Undefined`
- example: 

    ```vim
    let g:blink_point = {
        \'javascript':  '(|),{|},[|],{\n\s*|\n\s*},>|<,"|",''|''',
        \'vue':         '(|),{|},[|],".*|"',
        \'jsx':         '(|),{|},[|],".*|"',
        \}
    ```

#### `g:blink_point_default`

- description: 
    Default `pattern` that defines blink points if it's not defined in `g:block_point`.
- default: `'(|),{|},[|],{\n\s*|\n\s*},>|<,"|",''|'''`
- example: 

    ```vim
    let g:blink_point_default = '(|),{|},[|], ".*|"'
    ```

#### `g:blink_mapping_prev`

- description: blink to prev point mapping.
- default: `<c-p>`
- example: 

    ```vim
    let g:blink_mapping_prev = '<F1>'
    ```

#### `g:blink_mapping_next`

- description: blink to next point mapping.
- default: `<c-n>`
- example: 

    ```vim
    let g:blink_mapping_next = '<F2>'
    ```

[1]: https://github.com/VundleVim/Vundle.vim
[2]: https://github.com/tpope/vim-pathogen
[3]: https://github.com/junegunn/vim-plug
