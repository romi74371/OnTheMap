//
//  UdacityConstants.swift
//  OnTheMap
//
//  Created by Roman Hauptvogel on 20/09/15.
//  Copyright (c) 2015 Roman Hauptvogel. All rights reserved.
//

extension UdacityClient {
    
    // MARK: - Constants
    struct Constants {
        
        // MARK: API Key
        //static let ApiKey : String = "18bdcd8c987c465f9e12004d93dc73f4"
        
        // MARK: URLs
        static let BaseURL : String = "http://www.udacity.com/api/"
        static let BaseURLSecure : String = "https://www.udacity.com/api/"
        //static let AuthorizationURL : String = "https://www.themoviedb.org/authenticate/"
        
    }
    
    // MARK: - Methods
    struct Methods {
        
        // MARK: Session
        static let Session = "session"
        
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
        static let RequestToken = "request_token"
        static let Query = "query"
        
    }
    
    // MARK: - JSON Body Keys
    struct JSONBodyKeys {
        static let Udacity = "udacity" 
        static let Username = "username"
        static let Password = "password"
    }
    
    // MARK: - JSON Response Keys
    struct JSONResponseKeys {
        
        // MARK: General
        static let Account = "account"
        static let Registered = "registered"
        static let Status = "status"
        static let Error = "error"
        
    }
}
