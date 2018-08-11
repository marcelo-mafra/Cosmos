object UsersWebModule: TUsersWebModule
  OldCreateOrder = False
  OnCreate = WebModuleCreate
  Actions = <
    item
      Default = True
      Name = 'DefaultHandler'
      PathInfo = '/'
      OnAction = SecWebModuleDefaultHandlerAction
    end
    item
      Name = 'ServerTest'
      OnAction = SecWebModuleServerTestAction
    end>
  OnException = WebModuleException
  Height = 230
  Width = 415
  object DSHTTPWebDispatcher: TDSHTTPWebDispatcher
    Filters = <>
    WebDispatch.PathInfo = 'datasnap*'
    Left = 96
    Top = 75
  end
end
