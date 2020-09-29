pageextension 50103 "M3 Posted Purch. Invoices Ext." extends "Posted Purchase Invoices"
{
    layout
    {
        addafter("Location Code")
        {
            field("Proforma Invoice No."; "Proforma Invoice No.")
            {
                ApplicationArea = All;
                TableRelation = "M3 Proforma Invoice Header";
                DrillDown = true;

                trigger OnDrillDown()
                var
                    PageProfInv: page "M3 Purch. Proforma Invoice";
                    PI: Record "M3 Proforma Invoice Header";
                begin
                    if not PI.Get("Proforma Invoice No.") then exit;
                    PI.SetRange("No.", "Proforma Invoice No.");
                    PageProfInv.SetTableView(PI);
                    PageProfInv.SetRecord(PI);
                    PageProfInv.Run();
                end;
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
                Caption = 'Set Proforma Invoice No.';
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
                Caption = 'Remove Proforma Invoice No.';
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
                    PIReport: Report "M3 Proforma Invoice";
                    ProfInvHeader: Record "M3 Proforma Invoice Header";
                begin
                    TestField("Proforma Invoice No.");
                    ProfInvHeader.SetRange("No.", "Proforma Invoice No.");
                    PIReport.SetTableView(ProfInvHeader);
                    PIReport.RunModal();
                end;
            }
        }
    }
}
