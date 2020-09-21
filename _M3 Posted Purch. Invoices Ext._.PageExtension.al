pageextension 50103 "M3 Posted Purch. Invoices Ext." extends "Posted Purchase Invoices"
{
    layout
    {
        addafter("Location Code")
        {
            field("Proforma Invoice No."; "Proforma Invoice No.")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addlast(processing)
        {
            action("Set Proforma Invoice No.")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Set proforma Invoice No.';
                Image = Edit;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    PIH: Record "Purch. Inv. Header";
                    PI: Record "M3 Proforma Invoice Header";
                begin
                    CurrPage.SetSelectionFilter(PIH);
                    PI.UpsertProformaInvoice(PIH);
                    CurrPage.Update(false);
                end;
            }
            action("Remove Proforma Invoice No.")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Remove proforma Invoice No.';
                Image = Edit;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    PIH: Record "Purch. Inv. Header";
                    PI: Record "M3 Proforma Invoice Header";
                begin
                    CurrPage.SetSelectionFilter(PIH);
                    PI.RemovePIFromProformaInvoice(PIH);
                    CurrPage.Update(false);
                end;
            }
            action("Print Proforma Invoice")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Print Proforma Invoice';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                begin
                    Message('Proforma Invoice will print in near future.');
                end;
            }
        }
    }
}
