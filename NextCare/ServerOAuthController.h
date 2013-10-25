//
//  ServerOAuthController.h
//  NextCare
//
//  Created by Omar Metwally on 10/24/13.
//  Copyright (c) 2013 Novartis Hackathon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServerOAuthController : NSObject <UIWebViewDelegate>
{
    NSString *oauth_token_class;
    NSString *oauth_token_secret_class;
}

- (void)loginWithWebView:(UIWebView *)webWiew
              completion:(void (^)(NSDictionary *oauthTokens, NSError *error))completion;

- (void)requestAccessToken:(NSString *)oauth_token_secret
                oauthToken:(NSString *)oauth_token
             oauthVerifier:(NSString *)oauth_verifier
                completion:(void (^)(NSError *error, NSDictionary *responseParams))completion;

+ (NSURLRequest *)preparedRequestForPath:(NSString *)path
                              parameters:(NSDictionary *)parameters
                              HTTPmethod:(NSString *)method
                              oauthToken:(NSString *)oauth_token
                             oauthSecret:(NSString *)oauth_token_secret;

@property (nonatomic, strong) NSString *userid_class;


@end
