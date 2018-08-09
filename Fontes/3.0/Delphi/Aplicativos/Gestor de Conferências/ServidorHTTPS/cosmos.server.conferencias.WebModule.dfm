object ConfWebModule: TConfWebModule
  OldCreateOrder = False
  OnCreate = WebModuleCreate
  Actions = <
    item
      Default = True
      Name = 'DefaultHandler'
      PathInfo = '/'
      OnAction = ConfWebModuleDefaultHandlerAction
    end
    item
      Name = 'ServerTest'
      OnAction = ConfWebModuleServerTestAction
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
