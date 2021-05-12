# vim-blink

<p align="center">
<img alt="screencast" src="https://raw.githubusercontent.com/leafOfTree/leafOfTree.github.io/master/vim_run_screencast.gif" />
</p>

Blink to anywhere in INSERT or NORMAL mode

## Installation

<details>
<summary><a>How to install</a></summary>

- [VundleVim][1]

        Plugin 'leafOfTree/vim-blink'

- [vim-pathogen][2]

        cd ~/.vim/bundle
        git clone https://github.com/leafOfTree/vim-blink --depth 1

- [vim-plug][3]

        Plug 'leafOfTree/vim-blink'
        :PlugInstall

- Or manually, clone this plugin to `path/to/this_plugin`, and add it to `rtp` in vimrc

        set rtp+=path/to/this_plugin

<br />
</details>

Please stay up to date. Feel free to open an issue or a pull request

## Usage

Add config

```vim
let g:blink_point = {
    \'javascript':  '(|),{|},[|],{\n\s*|\n\s*},>|<,"|",''|''',
    \}
```

Open a javascript file and then in INSERT or NORMAL mode, press <kbd>c-n</kbd> or <kbd>c-p</kbd>

## Configuration

### Blink point

Each `blink point` is a `pattern` to match. It is a string separated by `,`. The cursor position is marked by `|`

#### `g:blink_point`

- description: filetype related `pattern`, format `{ key: <filetype>, value: pattern }`
- default: `undefined`
- example: 

    ```vim
    let g:blink_point = {
        \'javascript':  '(|),{|},[|],{\n\s*|\n\s*},>|<,"|",''|''',
        \'vue':         '(|),{|},[|],".*|"',
        \'jsx':         '(|),{|},[|],".*|"',
        \}
    ```

#### `g:blink_point_default`

- description: default `pattern`
- default: `'(|),{|},[|],{\n\s*|\n\s*},>|<,"|",''|'''`
- example: 

    ```vim
    let g:blink_point_default = '(|),{|},[|], ".*|"'
    ```

### Mapping

#### `g:blink_mapping_prev`

- description: mapping to blink to previous point
- default: `<c-p>`
- example: 

    ```vim
    let g:blink_mapping_prev = '<c-k>'
    ```

#### `g:blink_mapping_next`

- description: mapping to blink to next point
- default: `<c-n>`
- example: 

    ```vim
    let g:blink_mapping_next = '<c-j>'
    ```

### Mode

#### `g:blink_disable_insert`

- description: disable blink in INSERT mode
- default: `0`
- example: 

    ```vim
    let g:blink_disable_insert = 1
    ```

#### `g:blink_disable_normal`

- description: disable blink in NORMAL mode
- default: `0`
- example: 

    ```vim
    let g:blink_disable_normal = 1
    ```

### Function

The function used by the mappings is `blink#BlinkToEditPoint(flags, normal)`

```vim
inoremap<silent> <c-p> <c-r>=blink#BlinkToEditPoint("wb", 0)<cr>
inoremap<silent> <c-n> <c-r>=blink#BlinkToEditPoint("w", 0)<cr>

nnoremap<silent> <c-p> :call blink#BlinkToEditPoint("wb", 1)<cr>
nnoremap<silent> <c-n> :call blink#BlinkToEditPoint("w", 1)<cr>
```

[1]: https://github.com/VundleVim/Vundle.vim
[2]: https://github.com/tpope/vim-pathogen
[3]: https://github.com/junegunn/vim-plug
