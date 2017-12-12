module markdowneditor.header;

import gtk.Button;
import gtk.HeaderBar;

class Header
{
    HeaderBar container;
    Button open;
    Button save;
    Button saveAs;

    this()
    {
        this.container = new HeaderBar;
        this.container.setTitle("Markdown Viewer");
        this.container.setShowCloseButton(true);

        this.open = new Button("_Open");
        this.save = new Button("_Save");
        this.saveAs = new Button("Save _As");

        this.container.packStart(this.open);
        this.container.packEnd(this.save);
        this.container.packEnd(this.saveAs);
    }
}
