/// <summary>
/// Report C form pending Sales (ID 50091).
/// </summary>
/// Taneesh
Report 50091 "C form pending Sales"
{
    UsageCategory = Lists;
    RDLCLayout = './Layouts/CformpendingSales.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            // DataItemTableView = where("Form Code" = filter('C'));
            PrintOnlyIfDetail = false;
            RequestFilterFields = "Posting Date", "Location Code";
            column(BilltoName_SalesInvoiceHeader; "Sales Invoice Header"."Bill-to Name")
            {
            }
            column(FormCode_SalesInvoiceHeader; '"Sales Invoice Header"."Form Code"')
            {
            }
            column(Amount_SalesInvoiceHeader; "Sales Invoice Header".Amount)
            {
            }
            column(PostingDate_SalesInvoiceHeader; "Sales Invoice Header"."Posting Date")
            {
            }
            column(No_SalesInvoiceHeader; "Sales Invoice Header"."No.")
            {
            }
            column(txtbaseamt; txtbaseamt)
            {
            }
            column(txtamt; txtamt)
            {
            }
            column(totamt; totamt)
            {
            }
            column(ExternalDocumentNo_SalesInvoiceHeader; "Sales Invoice Header"."External Document No.")
            {
            }
            column(State; GetFilter("Sales Invoice Header".State))
            {
            }
            column(PostingDateforget; GetFilter("Sales Invoice Header"."Posting Date"))
            {
            }
            column(locecity; locecity)
            {
            }
            column(loceaddress; loceaddress)
            {
            }
            column(locationaddress2; locationaddress2)
            {
            }
            column(locstatecode; locstatecode)
            {
            }
            column(tinno; tinno)
            {
            }
            column(servicetextno; servicetextno)
            {
            }
            column(custtinno; custtinno)
            {
            }
            column(FormNo_SalesInvoiceHeader; '"Sales Invoice Header"."Form No."')
            {
            }
            trigger OnAfterGetRecord();
            begin
                txtbaseamt := 0;
                txtamt := 0;
                totamt := 0;
                SIL.Reset;
                SIL.SetRange(SIL."Document No.", "Sales Invoice Header"."No.");
                //SIL.SETRANGE(SIL."Sell-to Customer No.","Sales Invoice Header"."Bill-to Customer No.");

                DLE.Reset();
                DLE.SetRange("Document No.", "Sales Invoice Header"."No.");
                DLE.SetRange("Transaction Type", DLE."Transaction Type"::Sales);
                DLE.CALCSUMS(DLE."GST Amount", "GST Base Amount");
                txtbaseamt := DLE."GST Base Amount";
                txtamt := DLE."GST Amount";

                totamt := txtbaseamt + txtamt;

                // if SIL.FindFirst then
                //     repeat
                //         txtbaseamt += SIL."Tax Base Amount";
                //         txtamt += SIL."Tax Amount";
                //         totamt := txtbaseamt + txtamt;
                //     until SIL.Next = 0;
                location.Reset;
                location.SetRange(location.Code, "Sales Invoice Header"."Location Code");
                if location.FindFirst then
                    repeat
                        locecity := location.City;
                        loceaddress := location.Address;
                        locationaddress2 := location."Address 2";
                        locstatecode := location.Code;
                        tinno := 'Tin No-' + '';//location."T.I.N. No."
                                                //servicetextno := 'Service Tax No-' + location."Service Tax Registration No.";
                    until location.Next = 0;
                cust.Reset;
                cust.SetRange(cust."No.", "Sales Invoice Header"."Sell-to Customer No.");
                if cust.FindFirst then
                    repeat
                        custtinno := '';//cust."T.I.N. No."
                    until cust.Next = 0;
            end;

        }
        dataitem("Sales Cr.Memo Header"; "Sales Cr.Memo Header")
        {
            // DataItemTableView = where("Form Code" = filter(< '0'), "Form Code" = filter('C'));
            column(FormNo_SalesCrMemoHeader; ' "Sales Cr.Memo Header"."Form No."')
            {
            }
            column(FormCode_SalesCrMemoHeader; ' "Sales Cr.Memo Header"."Form Code"')
            {
            }
            column(PostingDate_SalesCrMemoHeader; "Sales Cr.Memo Header"."Posting Date")
            {
            }
            column(Amount_SalesCrMemoHeader; "Sales Cr.Memo Header".Amount)
            {
            }
            column(No_SalesCrMemoHeader; "Sales Cr.Memo Header"."No.")
            {
            }
            column(BilltoName_SalesCrMemoHeader; "Sales Cr.Memo Header"."Bill-to Name")
            {
            }
            column(txtbaseamt1; txtbaseamt1)
            {
            }
            column(txtamt1; txtamt1)
            {
            }
            column(totamt1; totamt1)
            {
            }
            column(custtinno1; custtinno1)
            {
            }
            trigger OnAfterGetRecord();
            begin
                scrmemolin.Reset;
                scrmemolin.SetRange(scrmemolin."Document No.", "Sales Cr.Memo Header"."No.");
                // if scrmemolin.FindFirst then
                //     repeat
                //         DLE.Reset();
                //         DLE.SetRange("Document No.", scrmemolin."Document No.");
                //         DLE.SetRange("Document Line No.", scrmemolin."Line No.");
                //         DLE.SetRange("Transaction Type", DLE."Transaction Type"::Sales);
                //         if DLE.FindFirst() then begin
                //             txtbaseamt1 += DLE."GST Base Amount";
                //             txtamt1 += DLE."GST Amount";
                //         end;
                //         totamt1 := txtbaseamt1 + txtamt1;
                //     until scrmemolin.Next = 0;

                DLE.Reset();
                DLE.SetRange("Document No.", "Sales Cr.Memo Header"."No.");
                DLE.SetRange("Transaction Type", DLE."Transaction Type"::Sales);
                DLE.CALCSUMS(DLE."GST Amount", "GST Base Amount");
                txtbaseamt1 := DLE."GST Base Amount";
                txtamt1 := DLE."GST Amount";

                totamt1 := txtbaseamt1 + txtamt1;

                cust1.Reset;
                cust1.Init;
                cust1.SetRange(cust1."No.", "Sales Cr.Memo Header"."Sell-to Customer No.");
                if cust1.FindFirst then
                    repeat
                        custtinno1 := '';//cust1."T.I.N. No."
                    until cust1.Next = 0;
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

        DLE: Record "Detailed GST Ledger Entry";
        SIL: Record "Sales Invoice Line";
        txtbaseamt: Decimal;
        txtamt: Decimal;
        totamt: Decimal;
        locecity: Text;
        location: Record Location;
        loceaddress: Text;
        locationaddress2: Text;
        locstatecode: Code[10];
        tinno: Text;
        servicetextno: Text;
        cust: Record Customer;
        custtinno: Text;
        txtbaseamt1: Decimal;
        scrmemolin: Record "Sales Cr.Memo Line";
        txtamt1: Decimal;
        totamt1: Decimal;
        custtinno1: Text;
        cust1: Record Customer;

}
