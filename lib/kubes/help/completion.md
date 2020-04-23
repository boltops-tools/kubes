## Examples

    kubes completion

Prints words for TAB auto-completion.

    kubes completion
    kubes completion hello
    kubes completion hello name

To enable, TAB auto-completion add the following to your profile:

    eval $(kubes completion_script)

Auto-completion example usage:

    kubes [TAB]
    kubes hello [TAB]
    kubes hello name [TAB]
    kubes hello name --[TAB]
