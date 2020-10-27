page 50104 "M3 Doc. Attachment Factbox"
{
    Caption = 'Document Attachment Factbox';
    PageType = CardPart;
    SourceTable = "M3 Document Attachment";
    RefreshOnActivate = true;

    layout
    {
        area(content)
        {
            group(General)
            {
                ShowCaption = false;
                field(Documents; NumberOfRecords)
                {
                    ApplicationArea = All;
                    Caption = 'Documents';
                    StyleExpr = TRUE;
                    ToolTip = 'Specifies the number of attachments.';

                    trigger OnDrillDown()
                    var
                        PageAttDocs: Page "M3 Document Attachment";
                    begin
                        PageAttDocs.SetDocumentRecordId(DocumentRecordId);
                        PageAttDocs.RunModal();
                    end;
                }
            }
        }
    }

    var
        DocumentRecordId: RecordId;

    trigger OnAfterGetCurrRecord()
    var
        currentFilterGroup: Integer;
    begin
        currentFilterGroup := Rec.FilterGroup;
        FilterGroup := 4;

        NumberOfRecords := 0;
        if Rec.GetFilters() <> '' then
            NumberOfRecords := Count;
        Rec.FilterGroup := currentFilterGroup;
    end;

    var
        NumberOfRecords: Integer;

    procedure SetRecordIDFilter(RecID: RecordId)
    var
        currentFilterGroup: Integer;
    begin
        DocumentRecordId := RecID;
        currentFilterGroup := Rec.FilterGroup;
        Rec.FilterGroup := 4;
        Rec.SetRange("Record ID", RecID);
        Rec.FilterGroup := currentFilterGroup;
    end;
}
