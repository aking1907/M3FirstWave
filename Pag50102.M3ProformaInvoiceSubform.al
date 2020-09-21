page 50102 "M3 Proforma Invoice Subform"
{

    Caption = 'M3 Proforma Invoice Subform';
    PageType = ListPart;
    SourceTable = "Lot No. Information";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Certificate Number"; "Certificate Number")
                {
                    Editable = false;
                    ApplicationArea = All;
                    DrillDown = true;

                    trigger OnDrillDown()
                    var
                        PIH: Record "Purch. Inv. Header";
                        PurchInvPage: Page "Posted Purchase Invoice";
                    begin
                        if PIH.Get("Certificate Number") then begin
                            PIH.SetRange("No.", "Certificate Number");
                            PurchInvPage.SetRecord(PIH);
                            PurchInvPage.SetTableView(PIH);
                            PurchInvPage.Run;
                        end;

                    end;
                }
                field("Container No."; "Container No.")
                {
                    ApplicationArea = All;
                }
                field("Lot No."; "Lot No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Item No."; "Item No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Price Gross"; "Price Gross")
                {
                    ApplicationArea = All;
                }
                field("Price Net"; "Price Net")
                {
                    ApplicationArea = All;
                }
                field("Pure Content, %"; "Pure Content, %")
                {
                    ApplicationArea = All;
                }
                field("Weight Gross"; "Weight Gross")
                {
                    ApplicationArea = All;
                }
                field("Weight Net"; "Weight Net")
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; "Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field(Origin; Origin)
                {
                    ApplicationArea = All;
                }
                field(Size; Size)
                {
                    ApplicationArea = All;
                }
                field(Subtotal; Subtotal)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

}
