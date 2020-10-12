page 50101 "M3 Purch. Proforma Invoice"
{

    Caption = 'Purch. Proforma Invoice';
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,,Print/Send';
    SourceTable = "M3 Proforma Invoice Header";
    RefreshOnActivate = true;
    InsertAllowed = false;
    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                }
                field("Shipper No."; Rec."Shipper No.")
                {
                    ApplicationArea = All;
                }
                field("Shipper Desc"; Rec."Shipper Desc")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Loading Point No."; Rec."Loading Point No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Loading Point Desc"; Rec."Loading Point Desc")
                {
                    ApplicationArea = All;
                }
                field("Delivery Point No."; Rec."Delivery Point No.")
                {
                    ApplicationArea = All;
                }
                field("Consignee Desc"; Rec."Consignee Desc")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Delivery Point Desc"; Rec."Delivery Point Desc")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Delivery Basis"; Rec."Delivery Basis")
                {
                    ApplicationArea = All;
                }
                field("Delivery Basis Desc"; Rec."Delivery Basis Desc")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
            }
            part(ProformaInvSubform; "M3 Proforma Invoice Subform")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "Proforma Invoice No." = FIELD("No.");
                UpdatePropagation = Both;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("&Print")
            {
                ApplicationArea = Basic, Suite;
                Caption = '&Print';
                Image = Print;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    PIReport: Report "M3 Proforma Invoice";
                    ProfInvHeader: Record "M3 Proforma Invoice Header";
                begin
                    ProfInvHeader.SetRange("No.", Rec."No.");
                    PIReport.SetTableView(ProfInvHeader);
                    PIReport.RunModal();
                end;
            }
        }
    }
}


