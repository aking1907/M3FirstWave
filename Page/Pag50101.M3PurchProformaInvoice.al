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
                field("No."; "No.")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; "Document Date")
                {
                    ApplicationArea = All;
                }
                field("Producer No."; "Producer No.")
                {
                    ApplicationArea = All;
                }
                field("Producer Desc"; "Producer Desc")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Consignee No."; "Consignee No.")
                {
                    ApplicationArea = All;
                }
                field("Consignee Desc"; "Consignee Desc")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Shipper No."; "Shipper No.")
                {
                    ApplicationArea = All;
                }
                field("Shipper Desc"; "Shipper Desc")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Loading Point No."; "Loading Point No.")
                {
                    ApplicationArea = All;
                }
                field("Loading Point Desc"; "Loading Point Desc")
                {
                    ApplicationArea = All;
                }
                field("Delivery Point No."; "Delivery Point No.")
                {
                    ApplicationArea = All;
                }
                field("Delivery Point Desc"; "Delivery Point Desc")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Delivery Basis"; "Delivery Basis")
                {
                    ApplicationArea = All;
                }
                field("Delivery Basis Desc"; "Delivery Basis Desc")
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