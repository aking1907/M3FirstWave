pageextension 50102 "M3 Lot No. Info Card Ext." extends "Lot No. Information Card"
{

    layout
    {
        addafter("Certificate Number")
        {
            field("Proforma Invoice No."; Rec."Proforma Invoice No.")
            {
                Editable = false;
                ApplicationArea = All;
            }
        }
        addafter(General)
        {
            group(Shipmrnt)
            {
                Caption = 'Shipment Information';

                field("Producer No."; Rec."Producer No.")
                {
                    ApplicationArea = All;
                }
                field("Producer Name"; Rec."Producer Name")
                {
                    ApplicationArea = All;
                }
                field("Container No."; Rec."Container No.")
                {
                    ApplicationArea = All;
                }
                field("Item Desc"; Rec."Item Desc")
                {
                    Caption = 'Item Description';
                    ApplicationArea = All;
                }
                field("Item Abbreviation Code"; Rec."Item Abbreviation Code")
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field(Size; Rec.Size)
                {
                    ApplicationArea = All;
                }
                field("Pure Content, %"; Rec."Pure Content, %")
                {
                    ApplicationArea = All;
                }
                field("Weight Gross"; Rec."Weight Gross")
                {
                    ApplicationArea = All;
                }
                field("Weight Net"; Rec."Weight Net")
                {
                    ApplicationArea = All;
                }
                field("Price Gross"; Rec."Price Gross")
                {
                    Caption = 'Price Pure';
                    ApplicationArea = All;
                }
                field("Price Net"; Rec."Price Net")
                {
                    Caption = 'Price';
                    ApplicationArea = All;
                }
                field(Subtotal; Rec.Subtotal)
                {
                    ApplicationArea = All;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                }
                field(Origin; Rec.Origin)
                {
                    ApplicationArea = All;
                }
            }

        }


        addafter(Control1905767507)
        {
            part("Attached Documents"; "M3 Doc. Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                UpdatePropagation = Both;
            }
            part(IncomingDocAttachFactBox; "M3 Incom. Doc. Attach. Factbox")
            {
                ApplicationArea = Basic, Suite;
                ShowFilter = false;
                Caption = 'Incoming Document Files';
                Visible = IsListPageVisible;
            }
        }
    }

    var
        IsListPageVisible: Boolean;

    trigger OnAfterGetRecord()
    var
        DocAtt: Record "Document Attachment";
    begin
        CurrPage."Attached Documents".Page.SetRecordIDFilter(Rec.RecordId);
        CurrPage.IncomingDocAttachFactBox.Page.SetRecordIDFilter(Rec.RecordId);

        DocAtt.SetRange("Record ID", Rec.RecordId);
        IsListPageVisible := DocAtt.Count > 0;
    end;

    // trigger OnAfterGetCurrRecord()
    // var
    //     DocAtt: Record "Document Attachment";
    // begin
    //     DocAtt.SetRange("Record ID", Rec.RecordId);
    //     IsListPageVisible := DocAtt.Count > 0;
    // end;
}

