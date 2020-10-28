page 50103 "M3 Document Attachment"
{
    Caption = 'Document Attachment Details';
    PageType = List;
    SourceTable = "M3 Document Attachment";
    RefreshOnActivate = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Attached By"; Rec."Attached By")
                {
                    ApplicationArea = All;
                    Visible = false;
                    Editable = false;
                }
                field("Table ID"; Rec."Table ID")
                {
                    ApplicationArea = All;
                    Visible = false;
                    Editable = false;
                }
                field("Document Reference ID"; Rec."Document Reference ID")
                {
                    ApplicationArea = All;
                    Visible = false;
                    Editable = false;
                }
                field("File Name"; Rec."File Name")
                {
                    ApplicationArea = All;
                    Editable = false;

                    trigger OnAssistEdit()
                    var
                    begin
                        if Rec."Document Reference ID".HasValue then
                            Rec.ExportBlobToFile()
                        else
                            Rec.ImportFileToBLOB(DocumentRecID);
                    end;
                }
                field("File Extension"; Rec."File Extension")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("File Type"; Rec."File Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Record ID"; Rec."Record ID")
                {
                    ApplicationArea = All;
                    Visible = false;
                    Editable = false;
                }
                field(User; Rec.User)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Attached Date"; Rec."Attached Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        "File Name" := SelectFileTxt;
    end;

    var
        DocumentRecID: RecordId;
        SelectFileTxt: Label 'Select File...';

    procedure SetDocumentRecordId(RecID: RecordId)
    var
        CurrentFilterGroup: Integer;
    begin
        DocumentRecID := RecID;
        CurrentFilterGroup := Rec.FilterGroup;
        Rec.FilterGroup := 4;
        Rec.SetRange("Record ID", DocumentRecID);
        Rec.FilterGroup := CurrentFilterGroup;
    end;
}
