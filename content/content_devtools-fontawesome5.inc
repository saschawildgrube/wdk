<?php

	class CMyContent extends CContentDevtools
	{
		function OnRenderContent(&$arrayItems)
		{
			$this->GetWebsite()->LoadStringResources("devtools");
			$this->GetWebsite()->ActivateFontAwesome5();
		}
	}
