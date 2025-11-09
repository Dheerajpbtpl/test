// Report 50053 "Sales G/L"
// {
//     UsageCategory = Lists;
//     RDLCLayout = './Layouts/SalesGL.rdlc';
//     DefaultLayout = RDLC;

//     dataset
//     {
//         dataitem("Sales Invoice Line"; "Sales Invoice Line")
//         {
//             DataItemTableView = where(Type = filter("G/L Account"), "No." = filter(<> '9140'));
//             RequestFilterFields = "Posting Date";
//             column(DocumentNo; "Sales Invoice Line"."Document No.")
//             {
//             }
//             column(No; "Sales Invoice Line"."No.")
//             {
//             }
//             column(LocationCode; "Sales Invoice Line"."Location Code")
//             {
//             }
//             column(Description; "Sales Invoice Line".Description)
//             {
//             }
//             column(UnitPrice; "Sales Invoice Line"."Unit Price")
//             {
//             }
//             column(Quantity; "Sales Invoice Line".Quantity)
//             {
//             }
//             column(Amount; "Sales Invoice Line".Amount)
//             {
//             }
//             column(PostingDate; Format("Posting Date"))
//             {
//             }
//             column(CustName; Cust.Name)
//             {
//             }
//             column(ProductCode; Item."Product Group Code")
//             {
//             }
//             column(UnitCostLCY; "Sales Invoice Line"."Unit Cost (LCY)")
//             {
//             }
//             column(CostAmount; "Unit Cost (LCY)" * Quantity)
//             {
//             }
//             column(Salesperson; "Sales Invoice Line".Salesperson)
//             {
//             }
//             column(Filters; Filters)
//             {
//             }
//             trigger OnPreDataItem();
//             begin
//                 Filters := GetFilters;
//             end;

//             trigger OnAfterGetRecord();
//             begin
//                 if Cust.Get("Sales Invoice Line"."Sell-to Customer No.") then;
//                 if Item.Get("Sales Invoice Line"."No.") then;
//             end;

//         }
//     }

//     requestpage
//     {


//         SaveValues = false;
//         layout
//         {
//             area(content)
//             {
//                 group(Options)
//                 {
//                     Caption = 'Options';

//                 }
//             }
//         }

//         actions
//         {
//         }
//     }


//     var
//         Cust: Record Customer;
//         Item: Record Item;
//         Filters: Text;

// }