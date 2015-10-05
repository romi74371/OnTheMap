//
//  ParseConstants.swift
//  OnTheMap
//
//  Created by Roman Hauptvogel on 03/10/15.
//  Copyright © 2015 Roman Hauptvogel. All rights reserved.
//

extension ParseClient {
    
    // MARK: - Constants
    struct Constants {
        
        // MARK: URLs
        static let BaseURL : String = "http://api.parse.com/1/classes/"
        static let BaseURLSecure : String = "https://api.parse.com/1/classes/"
        
    }
    
    // MARK: - Methods
    struct Methods {
        
        // MARK: Session
        static let StudentLocation = "StudentLocation"
        
        /*
        // MARK: Account
        static let Account = "account"
        static let AccountIDFavoriteMovies = "account/{id}/favorite/movies"
        static let AccountIDFavorite = "account/{id}/favorite"
        static let AccountIDWatchlistMovies = "account/{id}/watchlist/movies"
        static let AccountIDWatchlist = "account/{id}/watchlist"
        
        // MARK: Authentication
        static let AuthenticationTokenNew = "authentication/token/new"
        static let AuthenticationSessionNew = "authentication/session/new"
        
        // MARK: Search
        static let SearchMovie = "search/movie"
        
        // MARK: Config
        static let Config = "configuration"
        */
    }
    
    // MARK: - URL Keys
    struct URLKeys {
        
        static let UserID = "id"
        
    }
    
    // MARK: - Parameter Keys
    struct ParameterKeys {
        
        static let ApiKey = "api_key"
        static let SessionID = "session_id"
        static let Limit = "limit"
        static let Skip = "skip"
        static let Order = "order"
        
    }
    
    // MARK: - JSON Body Keys
    struct JSONBodyKeys {
        static let Username = "username"
        static let Password = "password"
    }
    
    // MARK: - JSON Response Keys
    struct JSONResponseKeys {
        
        // MARK: General
        static let Results = "results"
        static let Error = "error"
        
    }
}

