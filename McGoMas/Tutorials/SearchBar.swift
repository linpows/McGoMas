//
//  SearchBar.swift
//  McGoMas
//
//  Created by Mikayla Richardson on 4/18/20.
//  Copyright © 2020 Capstone. All rights reserved.
//

import SwiftUI

struct SearchBar: UIViewRepresentable {
    @Binding var query: String
    
    //Coordinator implements what happens upon text being entered
    class Coordinator: NSObject, UISearchBarDelegate {
        @Binding var query: String
        
        init(query: Binding<String>) {
            _query = query
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchQuery: String) {
            //Update our query. This allows UI to update to reflect what user types
            query = searchQuery
        }
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
        { //Dismiss keyboard when search button pressed
            searchBar.endEditing(true)
            searchBar.resignFirstResponder()
        }
        
    }
    
    //Make the delegate/coordinator for this search bar
    func makeCoordinator() -> SearchBar.Coordinator {
        return Coordinator(query: $query)
    }
    
    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        //Make a UISearchBar given a context of a SearchBar
        let bar = UISearchBar(frame: .zero)
        bar.delegate = context.coordinator
        bar.barStyle = .default
        bar.placeholder = "Search Tutorials"
        return bar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = query
    }
}

extension  UITextField{
    @objc func doneButtonTapped(button:UIBarButtonItem) -> Void {
       self.resignFirstResponder()
    }

}
