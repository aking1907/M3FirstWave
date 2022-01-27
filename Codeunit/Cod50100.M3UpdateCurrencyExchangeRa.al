codeunit 50100 "M3 Update Currency Exch. Rate"
{
    trigger OnRun()
    var
        UpdCurrExRate: Codeunit "Update Currency Exchange Rates";
    begin
        if UpdCurrExRate.Run() then;
    end;
}
