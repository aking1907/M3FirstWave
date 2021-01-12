tableextension 50107 "M3 Item Ledger Entry Ext." extends "Item Ledger Entry"
{
    procedure GetRemCostAmountActual(): Decimal
    begin
        if ("Invoiced Quantity" = 0) then 
            exit(0);

        exit("Cost Amount (Actual)" * "Remaining Quantity" / "Invoiced Quantity");
    end;
}
