pageextension 50452 salesOrderSubformEXT extends "Sales Order Subform"
{
    layout
    {
        // Add changes to page layout here
        addafter(Description)
        {
            field(SO_Line_KSS; Rec.SO_Line_KSS)
            {
                Caption = 'Sales Line KSS';
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}