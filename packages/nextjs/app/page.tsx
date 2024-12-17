"use client";

import Link from "next/link";
import type { NextPage } from "next";
import { useAccount } from "wagmi";
import { BugAntIcon, MagnifyingGlassIcon } from "@heroicons/react/24/outline";
import { Address, AddressInput } from "~~/components/scaffold-eth";
import { useScaffoldReadContract } from "~~/hooks/scaffold-eth";
import { useState } from "react";


const Home: NextPage = () => {
  const { address: connectedAddress } = useAccount(); // Devuelve el address que está conectada
  const prueba = useState("Ao");

  // const { data: totalCounter } = useScaffoldReadContract({
  //   contractName: "SimpleDEX",
  //   functionName: "getPrice"
  // });

  return (
    <>
      <div className="flex items-center flex-col flex-grow pt-10">
        <div className="px-5">
          <h1 className="text-center">
            <span className="block text-2xl mb-2">Bienvenido a</span>
            <span className="block text-4xl font-bold">SimpleDEX</span>
          </h1>
          <div className="flex justify-center items-center space-x-2 flex-col sm:flex-row">
            <p className="my-2 font-medium">Billetera conectada:</p>
            <Address address={connectedAddress} />
          </div>

        </div>


      </div>


    </>
  );






};

export default Home;
