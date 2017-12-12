module markdowneditor.content;

import gtk.Paned;
import gtk.ScrolledWindow;

import gsv.SourceBuffer;
import gsv.SourceLanguageManager;
import gsv.SourceStyleSchemeManager;
import gsv.SourceView;

class Content
{
    Paned container;
    Source source;

    this()
    {
        this.container = new Paned(GtkOrientation.HORIZONTAL);
        this.source = new Source;
        container.pack1(this.source.container, true, true);
        this.source.container.setSizeRequest(100, -1);
    }
}

class Source
{
    ScrolledWindow container;
    SourceBuffer buff;
    SourceView view;

    this()
    {
        this.buff = new SourceBuffer((new SourceLanguageManager).getLanguage("markdown"));
        this.buff.setStyleScheme((new SourceStyleSchemeManager).getScheme("Builder"));

        this.view = new SourceView(this.buff);
        this.view.setShowLineNumbers(true);
        this.view.setInsertSpacesInsteadOfTabs(true);
        this.view.setIndentWidth(4);
        this.view.setSmartBackspace(true);
        this.view.setRightMarginPosition(100);
        this.view.setShowRightMargin(true);
        this.view.setBackgroundPattern(GtkSourceBackgroundPatternType.GRID);

        this.container = new ScrolledWindow;

        this.container.addWithViewport(this.view);
    }
}
