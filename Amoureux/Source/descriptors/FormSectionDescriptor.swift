//
//  FormSectionDescriptor.swift
//  SwiftForms
//
//  Created by Miguel Angel Ortuno on 20/08/14.
//  Copyright (c) 2014 Miguel Angel Ortuño. All rights reserved.
//

import UIKit

class FormSectionDescriptor: NSObject {

    /// MARK: Properties
    
    var headerTitle: String!
    var footerTitle: String!
    
    var rows: [FormRowDescriptor] = []
    
    /// MARK: Public interface
    
    func addRow(row: FormRowDescriptor) {
        rows.append(row)
    }
    
    func removeRow(row: FormRowDescriptor) {
        if let index = find(rows, row) {
            rows.removeAtIndex(index)
        }
    }
}

// Copyright belongs to original author
// http://code4app.net (en) http://code4app.com (cn)
// From the most professional code share website: Code4App.net 
