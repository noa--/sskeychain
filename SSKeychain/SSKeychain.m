//
//  SSKeychain.m
//  SSToolkit
//
//  Created by Sam Soffes on 5/19/10.
//  Copyright (c) 2009-2011 Sam Soffes. All rights reserved.
//

#import "SSKeychain.h"

NSString *const kSSKeychainErrorDomain = @"com.samsoffes.sskeychain";
NSString *const kSSKeychainAccountKey = @"acct";
NSString *const kSSKeychainCreatedAtKey = @"cdat";
NSString *const kSSKeychainClassKey = @"labl";
NSString *const kSSKeychainDescriptionKey = @"desc";
NSString *const kSSKeychainLabelKey = @"labl";
NSString *const kSSKeychainLastModifiedKey = @"mdat";
NSString *const kSSKeychainWhereKey = @"svce";

#if __IPHONE_4_0 && TARGET_OS_IPHONE
    CFTypeRef SSKeychainAccessibilityType = NULL;
#endif

@implementation SSKeychain

+ (NSString *)passwordForService:(NSString *)serviceName account:(NSString *)account error:(NSError *__autoreleasing *) error {
    SSKeychainQuery *query = [SSKeychainQuery keychainQuery];
    query.service = serviceName;
    query.account = account;
    [query fetch:error];
    return query.password;
}


+ (BOOL)deletePasswordForService:(NSString *)serviceName account:(NSString *)account error:(NSError *__autoreleasing *) error {
    SSKeychainQuery *query = [SSKeychainQuery keychainQuery];
    query.service = serviceName;
    query.account = account;
    return [query delete:error];
}


+ (BOOL)setPassword:(NSString *)password forService:(NSString *)serviceName account:(NSString *)account error:(NSError *__autoreleasing *) error {
    SSKeychainQuery *query = [SSKeychainQuery keychainQuery];
    query.service = serviceName;
    query.account = account;
    query.password = password;
    return [query save:error];
}


+ (NSArray *)allAccountsWithError:(NSError *__autoreleasing *) error {
    return [self accountsForService:nil];
}


+ (NSArray *)accountsForService:(NSString *)serviceName error:(NSError *__autoreleasing *) error {
    SSKeychainQuery *query = [SSKeychainQuery keychainQuery];
    query.service = serviceName;
    return [query fetchAll:error];
}


+ (NSString *)passwordForService:(NSString *)serviceName account:(NSString *)account {
    return [self passwordForService:serviceName account:account error:nil];
}


+ (BOOL)deletePasswordForService:(NSString *)serviceName account:(NSString *)account {
    return [self deletePasswordForService:serviceName account:account error:nil];
}


+ (BOOL)setPassword:(NSString *)password forService:(NSString *)serviceName account:(NSString *)account {
    return [self setPassword:password forService:serviceName account:account error:nil];
}


+ (NSArray *)allAccounts {
    return [self allAccountsWithError:nil];
}


+ (NSArray *)accountsForService:(NSString *)serviceName {
    return [self accountsForService:serviceName error:nil];
}


#if __IPHONE_4_0 && TARGET_OS_IPHONE
+ (CFTypeRef)accessibilityType {
	return SSKeychainAccessibilityType;
}


+ (void)setAccessibilityType:(CFTypeRef)accessibilityType {
	CFRetain(accessibilityType);
	if (SSKeychainAccessibilityType) {
		CFRelease(SSKeychainAccessibilityType);
	}
	SSKeychainAccessibilityType = accessibilityType;
}
#endif

@end


