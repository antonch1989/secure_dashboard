<?php

namespace AppBundle\Controller;

use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\Request;

class DefaultController extends Controller
{
    /**
     * @Route("/", name="homepage")
     */
    public function indexAction(Request $request)
    {
        return $this->redirectToRoute('dashboard_index');
    }

    /**
     * @Route("/dashboard/", name="dashboard_index")
     */
    public function dashboardIndexAction(Request $request)
    {
        return $this->render('dashboard/index.html.twig');
    }
}
