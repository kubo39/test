import core.atomic : atomicOp;

import gdk.Event;
import gdk.Keysyms;
import gio.Application : GioApplication = Application;
import gtk.Application;
import gtk.ApplicationWindow;
import gtk.Button;
import gtk.Widget;
import gtk.Window;
import gsv.SourceBuffer;

import markdowneditor.content;
import markdowneditor.dialogs;
import markdowneditor.header;

import std.file : getcwd, readText;


class MarkdownEditorWindow : ApplicationWindow
{
private:

    void keyEvents(shared bool fullScreen)
    {
        auto editor = this.content.source.buff;
        auto headerBar = this.header.container;
        auto saveButton = this.header.save;

        auto handleID = addOnKeyPress(delegate(Event event, Widget widget) {
                switch (event.key().keyval)
                {
                case GdkKeysyms.GDK_F11:
                    if (fullScreen.atomicOp!"^"(true))
                        unfullscreen();
                    else
                        fullscreen();
                    break;
                // case GdkKeysyms.GDK_S:
                //     if (event.getState(GdkModifierType.CONTROL_MASK))
                //     {
                //     }
                //     break;
                default:
                    break;
                }
                return false;
            });
    }

    void openFile()
    {
        auto editor = this.content.source.buff;
        auto headerBar = this.header.container;
        this.header.open.addOnPressed(delegate(Button _) {
                auto openDialog = new OpenDialog(getcwd());
                auto newFile = openDialog.run();
                if (newFile !is null)
                {
                    string contents = readText(newFile);
                    headerBar.setTitle(newFile);
                    editor.setText(contents);
                }
            });
    }

    void saveEvent(Button saveButton, Button actualButton, bool saveAs)
    {
        auto editor = this.content.source.buff;
        auto headerBar = this.header.container;
    }

    void editorChanged()
    {
        this.content.source.buff.addOnChanged(delegate(editor) {
                auto markdown = editor.getText();
            });
    }

public:

    Header header;
    Content content;
    this(Application application)
    {
        super(application);
        this.header = new Header;
        this.content = new Content;

        setTitlebar(this.header.container);
        setTitle("Markdown Viewer");
        setWmclass("md-viewer", "Markdown Viewer");
        setDefaultSize(800, 600);
        setDefaultIconName("iconname");
        add(this.content.container);
    }

    void connectEvents()
    {
        editorChanged();
        openFile();
        saveEvent(this.header.save, this.header.save, false);
        saveEvent(this.header.save, this.header.saveAs, true);
        keyEvents(false);
    }
}


void main(string[] args)
{
    auto application = new Application("org.gtkd.markdownviewer", GApplicationFlags.FLAGS_NONE);
    application.addOnActivate(delegate void(GioApplication _) {
            auto window = new MarkdownEditorWindow(application);
            window.connectEvents();
            window.showAll();
        });
    application.run(args);
}
