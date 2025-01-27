"""
Configuration example for ``ptpython``.
Copy this file to $XDG_CONFIG_HOME/ptpython/config.py
On Linux, this is: ~/.config/ptpython/config.py
"""

from prompt_toolkit.styles import Style
from ptpython.style import default_ui_style
from pygments.token import Token


def configure(repl):
    """
    Configuration method. This is called during the start-up of ptpython.
    :param repl: `PythonRepl` instance.
    """

    # Autocompletion
    repl.complete_while_typing = False
    repl.enable_history_search = True

    # Vi mode
    repl.vi_mode = True

    # Colorscheme
    repl.color_depth = "DEPTH_24_BIT"  # True color.
    sonokai_code_style = {  # Based on https://github.com/sainnhe/sonokai
        "pygments": "#e2e2e3",
        "pygments.error": "#ff6077 bg:#55393d",
        "pygments.comment": "#7f8490",
        "pygments.keyword": "#fc5d7c",
        "pygments.keyword.constant": "#76cce0",
        "pygments.keyword.namespace": "#fc5d7c",
        "pygments.operator": "#fc5d7c",
        "pygments.punctuation": "#e2e2e3",
        "pygments.name": "#e2e2e3",
        "pygments.name.builtin": "#76cce0",
        "pygments.name.attribute": "#e2e2e3",
        "pygments.name.class": "#9ed072",
        "pygments.name.constant": "#f39660",
        "pygments.name.decorator": "#f39660",
        "pygments.name.exception": "#fc5d7c",
        "pygments.name.function": "#9ed072",
        "pygments.name.other": "#9ed072",
        "pygments.name.tag": "#ff6077",
        "pygments.literal": "#b39df3",
        "pygments.literal.date": "#b39df3",
        "pygments.literal.number": "#b39df3",
        "pygments.literal.string": "#e7c664",
        "pygments.literal.string.escape": "#b39df3",
        "pygments.generic.deleted": "#ff6077",
        "pygments.generic.emph": 'italic',
        "pygments.generic.inserted": "#a6e22e",
        "pygments.generic.output": "#e2e2e3",
        "pygments.generic.prompt": "#a7df78",
        "pygments.generic.strong": "bold",
        "pygments.generic.emphstrong": "bold italic",
        "pygments.generic.subheading": "#4e432f",
    }
    sonokai_ui_style = default_ui_style.copy()
    sonokai_ui_style.update({
        "in": "#9ed072",
        "in.number": "#a7df78 bold",
        "out": "#fc5d7c",
        "out.number": "#ff6077 bold",
        "prompt": "#a7df78",
        "prompt.dots": "#a7df78",
        "pygments.prompt": "#9ed072",
        "pygments.promptnum": "#a7df78 bold",
        "status-toolbar": "bg:#2c2e34 #e2e2e3",
        "status-toolbar.input-mode": "#85d3f2",
        "status-toolbar.key": "bg:#414550 #e2e2e3",
    })

    repl.install_code_colorscheme("sonokai", Style.from_dict(sonokai_code_style))
    repl.install_ui_colorscheme("sonokai", Style.from_dict(sonokai_ui_style))
    repl.use_code_colorscheme("sonokai")
    repl.use_ui_colorscheme("sonokai")

    # Min/max brightness
    # repl.min_brightness = 0.25  # Increase for dark terminal backgrounds.
    # repl.max_brightness = 1.0   # Decrease for light terminal backgrounds.

    # For ptipython, output prompt colors are handled by IPython
    if hasattr(repl, "ipython_shell"):
        repl.ipython_shell.highlighting_style_overrides = {
            Token.Prompt: "#9ed072",
            Token.PromptNum: "#a7df78 bold",
            Token.OutPrompt: "#fc5d7c",
            Token.OutPromptNum: "#ff6077 bold",
        }
        repl.ipython_shell.refresh_style()
