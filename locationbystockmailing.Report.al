/// <summary>
/// Report location by stock mailing (ID 50078).
/// </summary>
Report 50078 "location by stock mailing"
{
    RDLCLayout = './Layouts/locationbystockmailing.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            DataItemTableView = where("Remaining Quantity" = filter(> 0));
            RequestFilterFields = "Item No.";
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
            column(CHDCST; CHDCST)
            {
            }
            column(CHDVAT; CHDVAT)
            {
            }
            column(JKCST; JKCST)
            {
            }
            column(JKVAT; JKVAT)
            {
            }
            trigger OnAfterGetRecord();
            begin
                CHDCST := 0;
                CHDVAT := 0;
                DELCST := 0;
                DELVAT := 0;
                JKCST := 0;
                JKVAT := 0;
                LDHCST := 0;
                LDHVAT := 0;
                VI.Reset;
                VI.SetRange(VI."No.", "Item Ledger Entry"."Item No.");
                if VI.FindFirst then
                    VIname := VI."Vendor Item No.";
                ILE.Reset;
                ILE.SetRange(ILE."Item No.", "Item Ledger Entry"."Item No.");
                ILE.SetFilter(ILE."Location Code", '%1', 'DEL-VAT');
                if ILE.FindFirst then
                    repeat
                        DELVAT += ILE."Remaining Quantity"
until ILE.Next = 0;
                ILE.Reset;
                ILE.SetRange(ILE."Item No.", "Item Ledger Entry"."Item No.");
                ILE.SetFilter(ILE."Location Code", '%1', 'DEL-CST');
                if ILE.FindFirst then
                    repeat
                        DELCST += ILE."Remaining Quantity"
until ILE.Next = 0;
                ILE.Reset;
                ILE.SetRange(ILE."Item No.", "Item Ledger Entry"."Item No.");
                ILE.SetFilter(ILE."Location Code", '%1', 'LDH-CST');
                if ILE.FindFirst then
                    repeat
                        LDHCST += ILE."Remaining Quantity"
until ILE.Next = 0;
                ILE.Reset;
                ILE.SetRange(ILE."Item No.", "Item Ledger Entry"."Item No.");
                ILE.SetFilter(ILE."Location Code", '%1', 'LDH-VAT');
                if ILE.FindFirst then
                    repeat
                        LDHVAT += ILE."Remaining Quantity"
until ILE.Next = 0;
                ILE.Reset;
                ILE.SetRange(ILE."Item No.", "Item Ledger Entry"."Item No.");
                ILE.SetFilter(ILE."Location Code", '%1', 'CHD-CST');
                if ILE.FindFirst then
                    repeat
                        CHDCST += ILE."Remaining Quantity"
until ILE.Next = 0;
                ILE.Reset;
                ILE.SetRange(ILE."Item No.", "Item Ledger Entry"."Item No.");
                ILE.SetFilter(ILE."Location Code", '%1', 'CHD-VAT');
                if ILE.FindFirst then
                    repeat
                        CHDVAT += ILE."Remaining Quantity"
until ILE.Next = 0;
                ILE.Reset;
                ILE.SetRange(ILE."Item No.", "Item Ledger Entry"."Item No.");
                ILE.SetFilter(ILE."Location Code", '%1', 'J&K-CST');
                if ILE.FindFirst then
                    repeat
                        JKCST += ILE."Remaining Quantity"
until ILE.Next = 0;
                ILE.Reset;
                ILE.SetRange(ILE."Item No.", "Item Ledger Entry"."Item No.");
                ILE.SetFilter(ILE."Location Code", '%1', 'J&K-VAT');
                if ILE.FindFirst then
                    repeat
                        JKVAT += ILE."Remaining Quantity"
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
        CHDCST: Decimal;
        CHDVAT: Decimal;
        DELCST: Decimal;
        DELVAT: Decimal;
        JKCST: Decimal;
        JKVAT: Decimal;
        LDHCST: Decimal;
        LDHVAT: Decimal;

}
