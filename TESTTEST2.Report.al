Report 50101 "TEST TEST 2"
{
    RDLCLayout = './Layouts/TESTTEST2.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            DataItemTableView = where("Remaining Quantity" = filter(> 0));
            column(ItemNo_ItemLedgerEntry; "Item Ledger Entry"."Item No.")
            {
            }
            column(Description_ItemLedgerEntry; "Item Ledger Entry".Description)
            {
            }
            column(VIname; VIname)
            {
            }
            column(DELVAT; DELVAT)
            {
            }
            column(DELCST; DELCST)
            {
            }
            column(LDHCST; LDHCST)
            {
            }
            column(LDHVAT; LDHVAT)
            {
            }
            trigger OnAfterGetRecord();
            begin
                VI.Reset;
                VI.SetRange(VI."No.", "Item Ledger Entry"."Item No.");
                if VI.FindFirst then
                    VIname := VI."Vendor Item No.";
                ILE.Reset;
                ILE.SetRange(ILE."Item No.", "Item Ledger Entry"."Item No.");
                ILE.SetFilter(ILE."Location Code", '%1', 'DEL-VAT');
                if ILE.FindFirst then
                    repeat
                        DELVAT := ILE."Remaining Quantity"
until ILE.Next = 0;
                ILE.SetFilter(ILE."Location Code", '%1', 'DEL-CST');
                if ILE.FindFirst then
                    repeat
                        DELCST := ILE."Remaining Quantity"
until ILE.Next = 0;
                ILE.SetFilter(ILE."Location Code", '%1', 'LDH-CST');
                if ILE.FindFirst then
                    repeat
                        LDHCST := ILE."Remaining Quantity"
until ILE.Next = 0;
                ILE.SetFilter(ILE."Location Code", '%1', 'LDH-VAT');
                if ILE.FindFirst then
                    repeat
                        LDHVAT := ILE."Remaining Quantity"
until ILE.Next = 0;
            end;

        }
    }

    requestpage
    {


        SaveValues = false;
        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';

                }
            }
        }

        actions
        {
        }
    }



    var
        VI: Record Item;
        VIname: Text[50];
        ILE: Record "Item Ledger Entry";
        "CHD-CST": Decimal;
        "CHD-VAT": Decimal;
        DELCST: Decimal;
        DELVAT: Decimal;
        "J&K-CST": Decimal;
        "J&K-VAT": Decimal;
        LDHCST: Decimal;
        LDHVAT: Decimal;


}