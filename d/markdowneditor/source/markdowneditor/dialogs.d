module markdowneditor.dialogs;

import gtk.FileChooserDialog;
import gtk.Window;

class OpenDialog
{
    FileChooserDialog openDialog;

    this(string path)
    {
        this.openDialog = new FileChooserDialog("Open", new Window(WindowType.POPUP), FileChooserAction.OPEN);
        this.openDialog.addButton("Cancel", ResponseType.CANCEL);
        this.openDialog.addButton("Open", ResponseType.OK);
        this.openDialog.setCurrentFolder(path);
    }

    string run()
    {
        if (this.openDialog.run() == ResponseType.OK) {
            return this.openDialog.getFilename;
        } else {
            return null;
        }
    }
}
