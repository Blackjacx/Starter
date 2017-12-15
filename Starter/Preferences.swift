//
//  Preferences.swift
//  Starter
//
//  Created by Stefan Herold on 15.12.17.
//  Copyright © 2017 CodingCobra. All rights reserved.
//
// https://github.com/macmade/user-defaults/blob/master/swift/Preferences.swift

import Foundation

@objc public class Preferences: NSObject
{
    // Use properties of this class as your user default values.
    // They will automatically be saved in the defaults when set.
//    @objc public dynamic var lastStart: Date?
//    @objc public dynamic var fontName:  String?
//    @objc public dynamic var fontSize:  CGFloat = 0

    @objc public static let shared = Preferences()

    override init()
    {
        super.init()

        if let path = Bundle.main.path( forResource: "Defaults", ofType: "plist" )
        {
            UserDefaults.standard.register( defaults: NSDictionary( contentsOfFile: path ) as? [ String : Any ] ?? [ : ] )
        }

        for c in Mirror( reflecting: self ).children
        {
            guard let key = c.label else
            {
                continue
            }

            if let value = UserDefaults.standard.object( forKey: key )
            {
                self.setValue( value, forKey: key )
            }

            self.addObserver( self, forKeyPath: key, options: .new, context: nil )
        }
    }

    deinit
    {
        for c in Mirror( reflecting: self ).children
        {
            guard let key = c.label else
            {
                continue
            }

            self.removeObserver( self, forKeyPath: key )
        }
    }

    public override func observeValue( forKeyPath keyPath: String?, of object: Any?, change: [ NSKeyValueChangeKey : Any ]?, context: UnsafeMutableRawPointer? )
    {
        var found = false

        for c in Mirror( reflecting: self ).children
        {
            guard let key = c.label else
            {
                continue
            }

            if( key == keyPath )
            {
                UserDefaults.standard.set( change?[ NSKeyValueChangeKey.newKey ], forKey: key )

                found = true

                break
            }
        }

        if( found == false )
        {
            super.observeValue( forKeyPath: keyPath, of: object, change: change, context: context )
        }
    }
}
