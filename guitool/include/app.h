#ifndef __APP_H__
#define __APP_H__

//#include "resource.h"       // main symbols



class App : public CWinAppEx
{
public:
	App();


// Overrides
public:
	virtual BOOL InitInstance();

// Implementation

	virtual void PreLoadState();
	virtual void LoadCustomState();
	virtual void SaveCustomState();

	DECLARE_MESSAGE_MAP()
};

extern App theApp;


#endif