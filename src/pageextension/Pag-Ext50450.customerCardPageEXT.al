pageextension 50450 customerCardPageEXT extends "Customer Card"
{
    layout
    {
        // Add changes to page layout here
        addafter("No.")
        {
            field("Hold on Customer_KSS"; Rec."Hold on Customer")
            {
                ApplicationArea = All;
                Editable = true;
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