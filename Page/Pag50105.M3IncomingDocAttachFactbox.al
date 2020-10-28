page 50105 "M3 Incom. Doc. Attach. Factbox"
{

    Caption = 'Incoming Doc. Attach. Factbox';
    PageType = ListPart;
    SourceTable = "M3 Document Attachment";
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("File Name"; Rec."File Name")
                {
                    ApplicationArea = All;
                }
                field("File Type"; Rec."File Type")
                {
                    ApplicationArea = All;
                }
                field("Attached Date"; Rec."Attached Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
            }
        }
    }
    var
        DocumentRecordId: RecordId;

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
