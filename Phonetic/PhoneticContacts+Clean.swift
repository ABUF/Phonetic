//
//  PhoneticContacts+Clean.swift
//  Phonetic
//
//  Created by Augus on 2/13/16.
//  Copyright © 2016 iAugus. All rights reserved.
//

import Foundation
import Contacts

extension PhoneticContacts {
    
    var keysToFetchIfNeeded: [String] {
        var keys = [String]()
        
        if shouldCleanPhoneticNicknameKeys { keys.append(CNContactNicknameKey) }
        
        if shouldCleanPhoneticMiddleNameKeys { keys.append(CNContactPhoneticMiddleNameKey) }
        
        if shouldCleanPhoneticDepartmentKeys { keys.append(CNContactDepartmentNameKey) }
        
        if shouldCleanPhoneticCompanyKeys { keys.append(CNContactOrganizationNameKey) }
        
        if shouldCleanPhoneticJobTitleKeys { keys.append(CNContactJobTitleKey) }
        
        if shouldCleanPhoneticPrefixKeys { keys.append(CNContactNamePrefixKey) }
        
        if shouldCleanPhoneticSuffixKeys { keys.append(CNContactNameSuffixKey) }
        
        return keys
    }
    
    func removePhoneticKeysIfNeeded(mutableContact: CNMutableContact) {
        removePhoneticNicknameIfNeeded(mutableContact)
        removePhoneticMiddleNameIfNeeded(mutableContact)
        removePhoneticDepartmentKeysIfNeeded(mutableContact)
        removePhoneticCompanyKeysIfNeeded(mutableContact)
        removePhoneticJobTitleKeysIfNeeded(mutableContact)
        removePhoneticPrefixKeysIfNeeded(mutableContact)
        removePhoneticSuffixKeysIfNeeded(mutableContact)
    }
    
    private func removePhoneticNicknameIfNeeded(mutableContact: CNMutableContact) {
        removePhoneticKeysIfNeeded(mutableContact, shouldClean: shouldCleanPhoneticNicknameKeys, key: CNContactNicknameKey)
    }
    
    private func removePhoneticMiddleNameIfNeeded(mutableContact: CNMutableContact) {
        removePhoneticKeysIfNeeded(mutableContact, shouldClean: shouldCleanPhoneticMiddleNameKeys, key: CNContactPhoneticMiddleNameKey)
    }
    
    private func removePhoneticDepartmentKeysIfNeeded(mutableContact: CNMutableContact) {
        removePhoneticKeysIfNeeded(mutableContact, shouldClean: shouldCleanPhoneticDepartmentKeys, key: CNContactDepartmentNameKey)
    }
    
    private func removePhoneticCompanyKeysIfNeeded(mutableContact: CNMutableContact) {
        removePhoneticKeysIfNeeded(mutableContact, shouldClean: shouldCleanPhoneticCompanyKeys, key: CNContactOrganizationNameKey)
    }
    
    private func removePhoneticJobTitleKeysIfNeeded(mutableContact: CNMutableContact) {
        removePhoneticKeysIfNeeded(mutableContact, shouldClean: shouldCleanPhoneticJobTitleKeys, key: CNContactJobTitleKey)
    }
    
    private func removePhoneticPrefixKeysIfNeeded(mutableContact: CNMutableContact) {
        removePhoneticKeysIfNeeded(mutableContact, shouldClean: shouldCleanPhoneticPrefixKeys, key: CNContactNamePrefixKey)
    }
    
    private func removePhoneticSuffixKeysIfNeeded(mutableContact: CNMutableContact) {
        removePhoneticKeysIfNeeded(mutableContact, shouldClean: shouldCleanPhoneticSuffixKeys, key: CNContactNameSuffixKey)
    }
    
    private func removePhoneticKeysIfNeeded(mutableContact: CNMutableContact, shouldClean: Bool, key: String) {
        
        guard shouldClean else { return }
        
        if let _ = mutableContact.valueForKey(key) as? String {
            mutableContact.setValue("", forKey: key)
        }
    }
    
    
}

extension PhoneticContacts {
    
    private var shouldCleanPhoneticNicknameKeys: Bool {
        return shouldCleanPhoneticKey(kCleanPhoneticNickname, defaultBool: kCleanPhoneticNicknameDefaultBool)
    }
    
    private var shouldCleanPhoneticMiddleNameKeys: Bool {
        return shouldCleanPhoneticKey(kCleanPhoneticMiddleName, defaultBool: kCleanPhoneticMiddleNameDefaultBool)
    }
    
    private var shouldCleanPhoneticDepartmentKeys: Bool {
        return shouldCleanPhoneticKey(kCleanPhoneticDepartment, defaultBool: kCleanPhoneticDepartmentDefaultBool)
    }
    
    private var shouldCleanPhoneticCompanyKeys: Bool {
        return shouldCleanPhoneticKey(kCleanPhoneticCompany, defaultBool: kCleanPhoneticCompanyDefaultBool)
    }
    
    private var shouldCleanPhoneticJobTitleKeys: Bool {
        return shouldCleanPhoneticKey(kCleanPhoneticJobTitle, defaultBool: kCleanPhoneticJobTitleDefaultBool)
    }
    
    private var shouldCleanPhoneticPrefixKeys: Bool {
        return shouldCleanPhoneticKey(kCleanPhoneticPrefix, defaultBool: kCleanPhoneticPrefixDefaultBool)
    }
    
    private var shouldCleanPhoneticSuffixKeys: Bool {
        return shouldCleanPhoneticKey(kCleanPhoneticSuffix, defaultBool: kCleanPhoneticSuffixDefaultBool)
    }
    
    private func shouldCleanPhoneticKey(key: String, defaultBool: Bool) -> Bool {
        
        guard masterSwitchStatusIsOn else { return false }
        
        if userDefaults.valueForKey(key) == nil {
            userDefaults.setBool(defaultBool, forKey: key)
            userDefaults.synchronize()
        }
        return userDefaults.boolForKey(key)
    }
    
}