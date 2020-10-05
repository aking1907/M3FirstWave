page 50101 "M3 Purch. Proforma Invoice"
{

    Caption = 'Purch. Proforma Invoice';
    PageType = Card;
    SourceTable = "M3 Proforma Invoice Header";
    RefreshOnActivate = true;

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
                field("Producer No."; Rec."Producer No.")
                {
                    ApplicationArea = All;
                }
                field("Producer Desc"; Rec."Producer Desc")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Consignee No."; Rec."Consignee No.")
                {
                    ApplicationArea = All;
                }
                field("Consignee Desc"; Rec."Consignee Desc")
                {
                    ApplicationArea = All;
                    MultiLine = true;
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
                }
                field("Loading Point Desc"; Rec."Loading Point Desc")
                {
                    ApplicationArea = All;
                }
                field("Delivery Point No."; Rec."Delivery Point No.")
                {
                    ApplicationArea = All;
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

}
