#import "LinkBlockDefine.h"

#ifndef UITableViewNew
#define UITableViewNew ([UITableView new])
#endif
@interface NSObject(UITableViewLinkBlock)
/** <^(id<UITableViewDelegate> delegate)> */
LBDeclare UITableView*       (^tab_viewDelegate)(id<UITableViewDelegate> delegate);
/** <^(id<UITableViewDataSource> datasource)> */
LBDeclare UITableView*       (^tab_viewDataSource)(id<UITableViewDataSource> datasource);
/** <^(BOOL b)> */
LBDeclare UITableView*       (^tab_viewShowsHorizontal)(BOOL b);
/** <^(BOOL b)> */
LBDeclare UITableView*       (^tab_viewShowsVertical)(BOOL b);
@end
